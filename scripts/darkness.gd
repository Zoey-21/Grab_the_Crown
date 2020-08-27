extends Area2D

onready var player_data = get_node("/root/PlayerData")
onready var spr  = get_node("Sprite")


func _on_darkness_body_entered(body):
	if body.is_in_group("player"):
		if player_data.player_data["light"] == true:
			spr.visible = false
