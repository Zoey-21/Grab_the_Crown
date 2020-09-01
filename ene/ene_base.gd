extends KinematicBody2D

onready var player = get_node("../player")
var meat = preload("res://items/meat.tscn")
var speed = 5
var health = 1
var max_health = 1
var dead = false
var starting_pos = Vector2()
onready var sprite = $Sprite
onready var collis = $CollisionShape2D
onready var hit_collis = $hitbox/CollisionShape2D
onready var feet = $feet

func _ready():
	starting_pos = position


func hit():
	print(health)
	health -= player.gun_power
	if health < 0:
		var num = rand_range(0,5)
		print(num)
		if round(num) == 0:
			var meat_instance = meat.instance()
			meat_instance.position = get_global_position()
			get_tree().get_root().call_deferred("add_child",meat_instance)
		sprite.visible = false
		collis.set_deferred("disabled", true)
		hit_collis.set_deferred("disabled", true)
		feet.set_deferred("disabled", true)
		player.make_sound("res://resorces/sounds/ene_death.wav",0)
		health = max_health
		position = starting_pos
		dead =true
		if self.is_in_group("delete"):
			queue_free()


func _on_hitbox_body_entered(body):
	if !self.is_in_group("bird"):
		if body.is_in_group("player"):
			player.hit()
	if body.is_in_group("bullet"):
		hit()

func _on_VisibilityNotifier2D_screen_exited():
	sprite.visible = true
	collis.disabled = false
	feet.disabled = false
	dead = false
	

