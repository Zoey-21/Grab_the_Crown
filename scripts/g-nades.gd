extends Area2D

onready var player_data = get_node("/root/PlayerData")
onready var label = $Label

func _ready():
	if player_data.player_data["g-nades"]:
		queue_free()

func _on_gnades_body_entered(body):
	if body.is_in_group("player"):
		label.visible = true


func _on_gnades_body_exited(body):
	if body.is_in_group("player"):
		player_data.player_data["g-nades"] = true
		label.visible = false
		queue_free()
