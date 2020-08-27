extends "res://scripts/gun_base.gd"

func _ready():
	if player_data.player_data["gun3"]:
		queue_free()


func _on_gun_body_entered(body):
	if body.is_in_group("player"):
		player_data.player_data["gun"] += 1
		player_data.player_data["gun3"] = true
		queue_free()

