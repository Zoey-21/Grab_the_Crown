extends KinematicBody2D

var bullet = preload("res://ene/ene bullet.tscn")# loads bullet to fire


export var bullet_speed = 500 # speed for the bullet to move at
var shot_aim = Vector2(10.8, -1.16)# offset where it fires from

func fire():
	var bullet_instance = bullet.instance()# set up a instance of the bullet
	bullet_instance.position = get_global_position() + shot_aim #gives bullet player position
	bullet_instance.apply_central_impulse( Vector2(bullet_speed, 0).rotated(rotation)) #aplies force in direction
	get_tree().get_root().add_child(bullet_instance)# adds bullet to the root of the map
	

