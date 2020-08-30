extends Node2D


onready var z = get_node("z")
onready var z_out = get_node("z2")





func _physics_process(delta):
	if Input.is_action_just_pressed("shoot") or Input.is_action_just_pressed("jump"):
		get_tree().change_scene("res://levels/start_area.tscn")


func _on_Timer_timeout():
	z.visible = !z.visible
	z_out.visible = !z_out.visible

