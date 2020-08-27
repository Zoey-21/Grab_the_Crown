extends Area2D


func _on_meat_body_entered(body):
	if body.has_method("heal"):
		body.heal()
	queue_free()
