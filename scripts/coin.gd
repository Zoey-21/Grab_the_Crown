extends Area2D



func _on_coin_body_entered(_body):
	queue_free()
