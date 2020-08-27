extends Area2D

export var level = 0
onready var player_data = get_node("/root/PlayerData")

func _on_area_transition_body_entered(body):
	if body.is_in_group("player"):
		if player_data.player_data["collapsing"]:
			get_tree().change_scene("res://menus/story_end.tscn")
		match level:
			0:
				get_tree().change_scene("res://levels/leval.tscn")
				player_data.player_data["postion_save"] = Vector2(0,0)
			1:
				get_tree().change_scene("res://levels/end.tscn")
				player_data.player_data["postion_save"] = Vector2(0,0)
			3:
				get_tree().change_scene("res://levels/crown.tscn")
				player_data.player_data["postion_save"] = Vector2(0,0)
			4:
				get_tree().change_scene("res://levels/end.tscn")
				player_data.player_data["postion_save"] = Vector2(688,-1984)
			2:
				get_tree().change_scene("res://levels/leval.tscn")
				player_data.player_data["postion_save"] = Vector2(4384,2256)
			5:
				get_tree().change_scene("res://levels/start_area.tscn")
				player_data.player_data["postion_save"] = Vector2(3488, 1296)
