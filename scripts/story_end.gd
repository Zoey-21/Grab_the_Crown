extends Node2D

onready var z = get_node("Node2D/z")
onready var z_out = get_node("Node2D/z2")

func _physics_process(_delta):
	if Input.is_action_just_pressed("shoot") or Input.is_action_just_pressed("jump"):
		get_tree().change_scene("res://menus/main_menu.tscn")



func _on_Timer_timeout():
	z.visible = !z.visible
	z_out.visible = !z_out.visible
