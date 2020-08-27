extends Area2D

onready var player_data = get_node("/root/PlayerData")
onready var spr  = get_node("Sprite")
export var gem = 0

func _physics_process(_delta):
	match gem:
		0:
			spr.frame = 513
		1:
			spr.frame = 514
		2:
			spr.frame = 512
		
		


func _on_gem_body_entered(body):
	if body.is_in_group("player"):
		match gem:
			0:
				if player_data.player_data["blue"]:
					queue_free()
			1:
				if player_data.player_data["red"]:
					queue_free()
			2:
				if player_data.player_data["yellow"]:
					queue_free()

