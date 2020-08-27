extends Area2D


onready var player_data = get_node("/root/PlayerData")



func _on_Ladder_body_entered(body):
		if body.is_in_group("player"):
			player_data.player_data["can_climb"] = true


func _on_Ladder_body_exited(body):
		if body.is_in_group("player"):
			player_data.player_data["can_climb"] = false
