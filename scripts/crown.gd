extends Area2D

onready var player_data = get_node("/root/PlayerData")

func _ready():
	if player_data.player_data["crown"]:
		queue_free()


func _on_crown_body_entered(body):
	if body.is_in_group("player"):
		player_data.player_data["crown"] = true
		queue_free()
