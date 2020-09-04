extends Node2D

const SAVE_FILE_NAME = "user://ngsettings.save"
onready var player_data = get_node("/root/PlayerData")
onready var api = get_node("/root/newgrowndapi")
onready var enable = $enable
onready var login = $login
var result
var passportUrl = null
var saveFile = File.new()
onready var time_played = get_node("/root/timeplayed")

func _ready():
	time_played.stop()
	player_data.loading()
	Input.set_mouse_mode(0)
	if !music.playing:
		music.play_music("res://resorces/music/Grab The Crown - Main Theme.wav",-12)



func _on_start_pressed():
	player_data.delete()
	player_data.player_data["postion"] = Vector2(397,258)
	get_tree().change_scene("res://menus/story_start.tscn")

func _on_load_pressed():
	print(player_data.player_data["map"])
#	if !player_data.player_data["map"] == "map":
	music.stop()
	get_tree().change_scene(player_data.player_data["map"])


func _on_fullscreen_pressed():
		OS.window_fullscreen = !OS.window_fullscreen





	



func _on_credits2_pressed():
	$creditcam.current = true


func _on_credits3_pressed():
	$Camera2D.current = true



	
