extends Area2D

onready var player_data = get_node("/root/PlayerData")
onready var spr  = get_node("type")

func _ready():
	match player_data.player_data["gun"]:
		0:
			if player_data.player_data["gun"] == 1:
				queue_free()
		1:
			if player_data.player_data["gun"] == 2:
				queue_free()
		2:
			if player_data.player_data["gun"] == 3:
				queue_free()



func _physics_process(_delta):
	match player_data.player_data["gun"]:
		0:
			spr.frame = 469
		1:
			spr.frame = 470
		2:
			spr.frame = 475
		
		
