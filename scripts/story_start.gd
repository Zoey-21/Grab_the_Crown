extends Node2D


func _physics_process(delta):
	if Input.is_action_just_pressed("shoot") or Input.is_action_just_pressed("jump"):
		get_tree().change_scene("res://levels/start_area.tscn")
