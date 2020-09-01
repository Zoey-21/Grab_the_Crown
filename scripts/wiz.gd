extends "res://ene/ene_base.gd"

onready var shoot = $shoot
onready var anima = $AnimationPlayer


const JUMP_FORCE = 250
const SPRING_FORCE = 700
const REG_GRAVITY = 25
var GRAVITY = 25
const MAX_FALL_SPEED = 500
var y_velo = 0 
var fire_range = 100
var velo = Vector2()

func _ready():
	speed = 128
	health = 3
	max_health = 3

func _physics_process(_delta):
	if !dead:
		var player_dis_x = player.position.x - position.x
		var player_dis_y = player.position.y - position.y
		var move_dir = 0 
		if ( player_dis_x >= -160 && player_dis_x < 160 ) and ( player_dis_y >= -100 && player_dis_y < 100 ):
			if !( player_dis_x >= -80 && player_dis_x < 80 ):
				if player_dis_x > 0:
					move_dir += 1
				if player_dis_x < 0:
					move_dir -= 1

		move_and_slide(Vector2(move_dir * speed, y_velo),Vector2(0,-1))
	
		var grounded = is_on_floor()
		y_velo += GRAVITY
		if is_on_wall() :
			y_velo = -JUMP_FORCE
		if grounded and y_velo >= 5:
			y_velo = 5
		if y_velo > MAX_FALL_SPEED:
			y_velo = MAX_FALL_SPEED
		
		if grounded:
			if move_dir == 0:
				play_anim("idle")
			else:
				play_anim("walk")
		else:
			play_anim("jump")
			
		if player_dis_x < 0:
			shoot.shot_aim = Vector2(-10.8, -1.16)
			shoot.rotation_degrees = 180
		else:
			shoot.shot_aim = Vector2(10.8, -1.16)
			shoot.rotation_degrees = 0

func play_anim(anim):
	if anima.is_playing() and anima.current_animation == anim:
		return
	anima.play(anim)


func _on_shoot_timer_timeout():
	var player_dis_x = player.position.x - position.x
	
	if player_dis_x < fire_range:
		if -fire_range < player_dis_x:
			shoot.fire()
			

