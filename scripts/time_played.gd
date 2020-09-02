extends Timer


onready var player_data = get_node("/root/PlayerData")


func _on_Timer_timeout():
	player_data.player_data["time_played"] += 1
