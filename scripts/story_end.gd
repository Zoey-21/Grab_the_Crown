extends Node2D

onready var z = get_node("z")
onready var z_out = get_node("z2")

onready var held_gun = get_node("Node2D/gun")

onready var gun1 = get_node("Node2D/gui/gun2")
onready var gun2 = get_node("Node2D/gui/gun3")
onready var gun3 = get_node("Node2D/gui/gun4")
onready var light = get_node("Node2D/gui/light")
onready var gloves = get_node("Node2D/gui/gloves")
onready var gnades = get_node("Node2D/gui/gnades")

onready var player_data = get_node("/root/PlayerData")

onready var beat_game = get_node("beat_game")
onready var complete = get_node("100%")
onready var speed = get_node("speed")
onready var low = get_node("low%")


var start = false

var passportUrl
onready var api = get_node("/root/newgrowndapi")

func _ready():
	api.loading()
	ending()
	items()

		
func ending():
#	if time it takes to beet speed:
#		beat_game.visible = false
#		complete.visible = false
#		speed.visible = true
#		low.visible = false
#		_unlock(60320)
	if player_data.player_data["gun"] == 3 and player_data.player_data["light"]:
		beat_game.visible = false
		complete.visible = true
		speed.visible = false
		low.visible = false
		_unlock(60317)
	elif player_data.player_data["gun"] == 0 and !player_data.player_data["light"]:
		beat_game.visible = false
		complete.visible = false
		speed.visible = false
		low.visible = true
		_unlock(60318)
	else:
		beat_game.visible = true
		complete.visible = false
		speed.visible = false
		low.visible = false
		_unlock(60319)
		
func items():
	match player_data.player_data["gun"]:
		0:
			held_gun.visible = false
			gun1.visible = false
			gun2.visible = false
			gun3.visible = false
		1:
			held_gun.visible = true
			held_gun.frame = 469
			player_data.player_data["shootable"] = true
			gun1.visible = true
			gun2.visible = false
			gun3.visible = false
		2:
			held_gun.frame = 470
			gun1.visible = true
			gun2.visible = true
			gun3.visible = false
		3:
			held_gun.frame = 475
			gun1.visible = true
			gun2.visible = true
			gun3.visible = true
	
	
	if player_data.player_data["light"]:
		light.visible = true
	else:
		light.visible = false
	
	if player_data.player_data["gloves"]:
		gloves.visible = true
	else:
		gloves.visible = false
		
	if player_data.player_data["g-nades"]:
		gnades.visible = true
	else:
		gnades.visible = false

func _physics_process(_delta):
	if start:
		if Input.is_action_just_pressed("shoot") or Input.is_action_just_pressed("jump"):
			get_tree().change_scene("res://menus/main_menu.tscn")

func _on_Timer_timeout():
	z.visible = !z.visible
	z_out.visible = !z_out.visible
	


func _on_start_timeout():
	start = true


func _unlock(medalId):
	$NewGroundsAPI.Medal.unlock(medalId)
	var result = yield($NewGroundsAPI, 'ng_request_complete')
