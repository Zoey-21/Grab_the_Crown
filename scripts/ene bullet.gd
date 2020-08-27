extends RigidBody2D

var explution = preload("res://explotion.tscn")#loads explotion to play
onready var collition = get_node("CollisionShape2D")


func _physics_process(_delta):

	if  !get_node("notifier").is_on_screen():
		queue_free()

func kill():# deleate bullet
	queue_free()#remove from tree


func _on_bullet_body_entered(body):
	if body.is_in_group("player"): #if hitting player
		body.hit()
	kill()
	var explution_instance = explution.instance() #make explotion instance
	explution_instance.position = get_global_position() #get location of hit
	get_tree().get_root().add_child(explution_instance) #show explotion


func _on_notifier_screen_exited():
	queue_free()
