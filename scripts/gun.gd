extends "res://scripts/gun_base.gd"

onready var label = $Label

func _ready():
	if player_data.player_data["gun1"]:
		queue_free()


func _on_gun_body_entered(body):
	if body.is_in_group("player"):
		label.visible = true



func _on_gun_body_exited(body):
	if body.is_in_group("player"):
		player_data.player_data["gun"] += 1
		player_data.player_data["gun1"] = true
		label.visible = false
		queue_free()
