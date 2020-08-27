extends Node2D

onready var player_data = get_node("/root/PlayerData")

func _ready():
	player_data.loading()

func _on_start_pressed():
	player_data.delete()
	player_data.player_data["postion"] = Vector2(397,258)
	get_tree().change_scene("res://menus/story_start.tscn")



func _on_load_pressed():
	print(player_data.player_data["map"])
#	if !player_data.player_data["map"] == "map":
	get_tree().change_scene(player_data.player_data["map"])


func _on_fullscreen_pressed():
		OS.window_fullscreen = !OS.window_fullscreen
