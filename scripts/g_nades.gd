extends KinematicBody2D

onready var player = get_node("../player")
onready var player_data = get_node("/root/PlayerData")

onready var sprite = $Sprite
onready var explotion = $explotion
onready var blast = $blast/CollisionShape2D
onready var end_timer = $end_timer

func _ready():
	explotion.visible = false
	blast.disabled = true

func _on_ex_timer_timeout():
	explotion.visible = true
	blast.disabled = false
	end_timer.start()
	player.make_sound("res://resorces/sounds/Explosion.wav",0)
	player_data.player_data["g-nades_out"] -= 1
	print(player_data.player_data["g-nades_out"])


func _on_blast_body_entered(body):
	if body.has_method("hit"):
		body.hit()
		print("hit")
	

func _on_end_timer_timeout():
	queue_free()
	
