extends Area2D

onready var anim = $AnimationPlayer
onready var reset = $reset
onready var spr = $Sprite

func _on_spring_body_entered(body):
	if body.has_method("spring"):
		
		if anim.is_playing() and anim.current_animation == "spring":
			return
		anim.play("spring")
		reset.start()
		body.spring()


func _on_reset_timeout():
	spr.frame = 261 

