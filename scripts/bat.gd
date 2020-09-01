extends "res://ene/ene_base.gd"


onready var player_data = get_node("/root/PlayerData")
onready var raycast = $RayCast2D
onready var anim = $AnimationPlayer
onready var nav = get_node("../Navigation2D")
var state = 0
var first_time = true
var player_pos 
var path = []


func _ready():
	speed = 50
	health = 5
	max_health = 5


func _physics_process(_delta):
	if !dead:
		match state:
			0:
				play_anim("idle")
				if raycast.is_colliding():
					state = 1
					raycast.enabled = false
			1:
				play_anim("dive")
				if first_time == true:
					player_pos = round(player.global_position.y)
					first_time = false
				if round(global_position.y) < player_pos:
					global_position.y += 2
				else:
					state = 2
			2:
				play_anim("flap")
				update_path(global_position,player.global_position)


func play_anim(anim_play):
	if anim.is_playing() and anim.current_animation == anim_play:
		return
	anim.play(anim_play)

func update_path(start,end):
	end.x = end.x
	end.y = end.y
	path = nav.get_simple_path(start,end,true)
	path.remove(0)
	set_process(true)
	
func _process(delta):
	var walk_dis = speed * delta
	move_along_path(walk_dis)
	
func move_along_path(dis):
	var last_pont = position
	for _index in range(path.size()):
		var distance_between = last_pont.distance_to(path[0])
		if dis <= distance_between:
			position = last_pont.linear_interpolate(path[0],dis / distance_between)
			break
		elif dis < 0.0:
			position = path[0]
			set_process(false)
			break
		dis -= distance_between
		last_pont = path[0]
		path.remove(0)

func _on_VisibilityNotifier2D_screen_exited():
	state = 0
	raycast.enabled = true
	global_position = starting_pos
	sprite.visible = true
	collis.disabled = false
	feet.disabled = false
	dead = false
	path.resize(0)
	



