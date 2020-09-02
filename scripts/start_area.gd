extends Node2D

onready var music = get_node("/root/music")
onready var player_data = get_node("/root/PlayerData")
onready var time_played = get_node("/root/timeplayed")

func _ready():
	time_played.start()
	if player_data.player_data["crown"]:
		return
	elif music.playing:
		music.stop()
