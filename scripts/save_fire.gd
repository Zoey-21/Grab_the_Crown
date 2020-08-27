extends Area2D


onready var player_data = get_node("/root/PlayerData")
onready var save = $save
onready var level = get_node("../")


func _on_save_fire_body_entered(body):
	if body.is_in_group("player"):
		if !player_data.player_data["collapsing"]:
			player_data.player_data["postion_save"] = position
			player_data.player_data["map"] = level.get_filename()
			save.visible = true
			player_data.save()

func _on_save_fire_body_exited(body):
	if body.is_in_group("player"):
		save.visible = false
