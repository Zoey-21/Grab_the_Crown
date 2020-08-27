extends "res://ene/ene_base.gd"


var angle
var place = Vector2()
var velo = Vector2()
var rand_numb #random number for movement



func _ready():
	speed = 10
	max_health = 1
	health = 1

func _physics_process(delta):
	if !dead:
		angle = get_angle_to(place)# gets player position form global
	
		if player.position < self.position: #if player is on the left 
			sprite.set_flip_h(true)# flip horazontal
		else:
			sprite.set_flip_h(false)# dont flip
			
			
		velo.x = cos(angle)#gets velo from angle
		velo.y = sin(angle)
		move_and_collide(velo * speed * delta)
		rotation_degrees = angle




func _on_fly_time_timeout():
	rand_numb = randi() % 4 + 1 # makes random number from 1 to 4
	match rand_numb: # switch statment useing random numbers
		1:
			place.x = position.x + 15 #right movment
		2:
			place.x = position.x - 15 # left movment
		3:
			place.y = position.y + 15 # down movment
		4:
			place.y = position.y - 15 #up movment





