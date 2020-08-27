extends Area2D

onready var player_data = get_node("/root/PlayerData")
onready var spr  = get_node("Sprite")
export var key = 0

func _ready():
	match key:
		0:
			if player_data.player_data["blue"]:
				queue_free()
		1:
			if player_data.player_data["red"]:
				queue_free()
		2:
			if player_data.player_data["yellow"]:
				queue_free()


func _physics_process(_delta):
	match key:
		0:
			spr.frame = 561
		1:
			spr.frame = 562
		2:
			spr.frame = 560
		
		


func _on_key_body_entered(body):
	if body.is_in_group("player"):
		match key:
			0:
				player_data.player_data["blue"] = true
			1:
				player_data.player_data["red"] = true
			2:
				player_data.player_data["yellow"] = true
		queue_free()
		
