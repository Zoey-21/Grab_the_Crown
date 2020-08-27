extends Node2D


func _physics_process(_delta):
	if Input.is_action_just_pressed("shoot") or Input.is_action_just_pressed("jump"):
		get_tree().change_scene("res://menus/main_menu.tscn")

