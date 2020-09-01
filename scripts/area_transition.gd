extends Area2D

export var level = 0
onready var player_data = get_node("/root/PlayerData")
onready var player = get_node("../player")

func _on_area_transition_body_entered(body):
	if body.is_in_group("player"):
		
		if player_data.player_data["collapsing"]:
			get_tree().change_scene("res://menus/story_end.tscn")
			
		player_data.player_data["postion_save"] = player.position
		match level:
			0:
				get_tree().change_scene("res://levels/leval.tscn")
			1:
				get_tree().change_scene("res://levels/end.tscn")
			3:
				get_tree().change_scene("res://levels/crown.tscn")
			4:
				get_tree().change_scene("res://levels/end.tscn")
			2:
				get_tree().change_scene("res://levels/leval.tscn")
			5:
				get_tree().change_scene("res://levels/start_area.tscn")
