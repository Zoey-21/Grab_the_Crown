extends Node2D


onready var music = get_node("/root/music")
onready var time_played = get_node("/root/timeplayed")

func _ready():
	time_played.start()
	if !music.playing:
		music.play_music("res://resorces/music/Tranquility Base.wav",-12)
