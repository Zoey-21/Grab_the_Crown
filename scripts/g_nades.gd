extends KinematicBody2D

onready var player = get_node("../player")

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


func _on_blast_body_entered(body):
	end_timer.start()
	if body.has_method("hit"):
		body.hit()
		print("hit")
	player.make_sound("res://resorces/sounds/Explosion.wav",0)
	

func _on_end_timer_timeout():
	queue_free()
	
