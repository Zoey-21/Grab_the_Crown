extends KinematicBody2D

const SPEED = 150
const JUMP_FORCE = 500
const SPRING_FORCE = 700
const REG_GRAVITY = 25
var GRAVITY = 25
const MAX_FALL_SPEED = 500

var gun_power = 1

onready var player = $AnimationPlayer
onready var sprite = $Sprite
onready var gun = $gun
onready var player_data = get_node("/root/PlayerData")
onready var shoot = $shoot
onready var invic = $invic

onready var hp_1 = $gui/heart
onready var hp_2 = $gui/heart2
onready var hp_3 = $gui/heart3

onready var red = $gui/red
onready var blue = $gui/blue
onready var yellow = $gui/yellow

onready var light = $gui/light
onready var gloves = $gui/gloves
onready var gnades = $gui/gnades
onready var crown = $gui/crown

onready var warning = $gui/warning
onready var col_timer = Timer.new()
var collapsing = false

onready var sound = $sound_maker
onready var walk = $sound_maker2
onready var climb = $sound_maker3

var gnade = preload("res://player/g_nades.tscn")
var gnade_aim = Vector2(10.8, 0)

var y_velo = 0 
var facing_right = true

var is_walking = true
var is_clibing = true
var can_jump = true
onready var can_jump_timer = $can_jump

var can_get_hit = true

func _ready():
	position = player_data.player_data["postion_save"]
	Input.set_mouse_mode(1)
	player_data.player_data["g-nades_out"] = 0
	if player_data.player_data["collapsing"]:
		get_tree().get_root().get_node("col_timer").connect("timeout",self,"_on_col_timer_timeout") 

func _physics_process(_delta):
	
	if Input.is_action_just_pressed("fullscreen"):
		OS.window_fullscreen = !OS.window_fullscreen
	
	var move_dir = 0  
	
	if Input.is_action_pressed("move_right"):
		move_dir += 1
		if is_walking and is_on_floor():
			walk.play()
			is_walking = false
	if Input.is_action_pressed("move_left"):
		move_dir -= 1
		if is_walking and is_on_floor():
			walk.play()
			is_walking = false

	move_and_slide(Vector2(move_dir * SPEED, y_velo),Vector2(0,-1))

	
	if is_on_ceiling():
		y_velo = 0
	
	var grounded = is_on_floor()
	if grounded:
		can_jump_timer.start()
		can_jump = true
	
	y_velo += GRAVITY
	if !player_data.player_data["can_climb"]:
		if can_jump and Input.is_action_just_pressed("jump"):
			y_velo = -JUMP_FORCE
			make_sound("res://resorces/sounds/Jump.wav",-5)
		if Input.is_action_just_released("jump"):
			if y_velo < -100:
				y_velo = -100
		
	if grounded and y_velo >= 5:
		y_velo = 5
	if y_velo > MAX_FALL_SPEED:
		y_velo = MAX_FALL_SPEED
		
	if facing_right and move_dir < 0:
		flip()
	if !facing_right and move_dir > 0:
		flip()
		
	if grounded:
		if move_dir == 0:
			play_anim("idle")
		else:
			play_anim("walk")
	else:
		play_anim("jump")
	
	if player_data.player_data["finished"]:
		$Camera2D.current = true

	items()
	
	gui()

func hit():
	if can_get_hit:
		player_data.player_data["health"] -= 1
		make_sound("res://resorces/sounds/player_hit.wav",3)
		can_get_hit = false
		invic.start()

func heal():
	if player_data.player_data["health"] < 3:
		make_sound("res://resorces/sounds/heal.wav",0)
		player_data.player_data["health"] += 1

func flip():
	facing_right = !facing_right
	sprite.flip_h = !sprite.flip_h
	gun.flip_h = !gun.flip_h
	if gun.flip_h == true:
		gun.position = Vector2(-8.142, 0.347)
		shoot.shot_aim = Vector2(-10.8, -1.16)
		shoot.rotation_degrees = 180
		gnade_aim.x = -10.8
	else:
		gun.position = Vector2(8.142, -0.347)
		shoot.shot_aim = Vector2(10.8, -1.16)
		shoot.rotation_degrees = 0
		gnade_aim.x = 10.8

func play_anim(anim):
	if player.is_playing() and player.current_animation == anim:
		return
	player.play(anim)

func _on_invic_timeout():
	can_get_hit = true

func gui():
	match player_data.player_data["gun"]:
		0:
			gun.visible = false
		1:
			gun.visible = true
			gun.frame = 469
			gun_power = 1
			player_data.player_data["shootable"] = true
		2:
			gun.frame = 470
			gun_power = 2
		3:
			gun.frame = 475
			gun_power = 3
	
	match player_data.player_data["health"]:
		3:
			hp_1.visible = true
			hp_2.visible = true
			hp_3.visible = true
		2:
			hp_1.visible = true
			hp_2.visible = true
			hp_3.visible = false
		1:
			hp_1.visible = true
			hp_2.visible = false
			hp_3.visible = false
	if player_data.player_data["health"] <= 0:
		hp_1.visible = false
		hp_2.visible = false
		hp_3.visible = false
		respawn()
			
	if player_data.player_data["red"]:
		red.visible = true
	else:
		red.visible = false
	
	if player_data.player_data["blue"]:
		blue.visible = true
	else:
		blue.visible = false
	
	if player_data.player_data["yellow"]:
		yellow.visible = true
	else:
		yellow.visible = false
	
	if player_data.player_data["light"]:
		light.visible = true
	else:
		light.visible = false
	
	if player_data.player_data["gloves"]:
		gloves.visible = true
	else:
		gloves.visible = false
		
	if player_data.player_data["g-nades"]:
		gnades.visible = true
	else:
		gnades.visible = false
		
	if player_data.player_data["crown"]:
		crown.visible = true
		warning.visible = true
		if !player_data.player_data["timer_started"]:
			$gui/warning/start_timer.start()
			player_data.player_data["timer_started"] = true
		
	else:
		crown.visible = false
	
	if player_data.player_data["collapsing"]:
		warning.set_text(str(round(get_tree().get_root().get_node("col_timer").time_left)))
		
func respawn():
	music.play_music("res://resorces/music/Tranquility Base.wav",-12)
	position = player_data.player_data["postion_save"]
	if player_data.player_data["collapsing"]:
		get_tree().get_root().get_node("col_timer").queue_free()
	player_data.loading()
	get_tree().change_scene(player_data.player_data["map"])
	player_data.player_data["health"] = 3

func spring():
	y_velo = -SPRING_FORCE
	make_sound("res://resorces/sounds/spring.wav",-5)

func items():
			
	if player_data.player_data["shootable"] == true:
		if Input.is_action_just_pressed("shoot") and !Input.is_action_pressed("move_down"):
			shoot.fire()
			make_sound("res://resorces/sounds/player_fire.wav",-2)
			
	if player_data.player_data["gloves"]:
		if is_on_wall():
			if is_clibing:
				climb.play()
				is_clibing = false
			GRAVITY = 0
			y_velo = -JUMP_FORCE /2
		else:
			GRAVITY = REG_GRAVITY
	
	if player_data.player_data["can_climb"]:
		if Input.is_action_pressed("move_up") or Input.is_action_pressed("jump"):
			GRAVITY = 0
			y_velo = -JUMP_FORCE /2
	else:
		GRAVITY = REG_GRAVITY
	
	if player_data.player_data["g-nades"]:
		if Input.is_action_pressed("move_down") and Input.is_action_just_pressed("shoot") and is_on_floor() and player_data.player_data["g-nades_out"] != 2:
				var gnade_instance = gnade.instance()# set up a instance of the bullet
				gnade_instance.position = get_global_position() + gnade_aim #gives bullet player position
				get_node("..").add_child(gnade_instance)# adds bullet to the root of the map
				player_data.player_data["g-nades_out"] += 1
				print(player_data.player_data["g-nades_out"])

func _on_light_area_entered(area):
	if area.is_in_group("dark"):
		if player_data.player_data["light"] == true:
			area.visible = false

func _on_start_timer_timeout():
	col_timer.wait_time = 180
	col_timer.name = "col_timer"
	col_timer.connect("timeout",self,"_on_col_timer_timeout") 
	get_tree().get_root().add_child(col_timer)
	col_timer.start()
	player_data.player_data["collapsing"] = true

func _on_col_timer_timeout():
	make_sound("res://resorces/sounds/Explosion.wav",0)
	respawn()

func make_sound(audio,vol):
	audio = load(audio)
	sound.set_stream(audio)
	sound.set_volume_db(vol)
	sound.play()

func _on_sound_maker2_finished():
	is_walking = true

func _on_can_jump_timeout():
	can_jump = false

func _on_sound_maker3_finished():
	is_clibing = true
