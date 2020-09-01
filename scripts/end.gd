extends Node2D

onready var player_data = get_node("/root/PlayerData")

onready var pl_gui = $player/gui
onready var cam_gui = $Camera2D/gui

onready var hp_1 = $Camera2D/gui/heart
onready var hp_2 = $Camera2D/gui/heart2
onready var hp_3 = $Camera2D/gui/heart3

onready var red = $Camera2D/gui/red
onready var blue = $Camera2D/gui/blue
onready var yellow = $Camera2D/gui/yellow

onready var light = $Camera2D/gui/light
onready var gloves = $Camera2D/gui/gloves
onready var gnades = $Camera2D/gui/gnades

var up = false

func _ready():
	$Camera2D.current = true
	pl_gui.visible = false
	cam_gui.visible = true

func _physics_process(_delta):
	gui()
	if up:
		if !player_data.player_data["finished"]:
			$Camera2D.current = true
			pl_gui.visible = false
			cam_gui.visible = true
			$Camera2D.position.y -=  0.8
	else:
		$player/Camera2D.current = true
		$Camera2D/death_plane/CollisionShape2D.disabled
		pl_gui.visible = true
		cam_gui.visible = false

func gui():
	match player_data.player_data["health"]:
		3:
			hp_1.visible = true
			hp_2.visible = true
			hp_3.visible = true
		2:
			hp_1.visible = true
			hp_2.visible = true
			hp_3.visible = false
		1:
			hp_1.visible = true
			hp_2.visible = false
			hp_3.visible = false
	if player_data.player_data["health"] < 0:
		hp_1.visible = false
		hp_2.visible = false
		hp_3.visible = false
			
	if player_data.player_data["red"]:
		red.visible = true
	else:
		red.visible = false
	
	if player_data.player_data["blue"]:
		blue.visible = true
	else:
		blue.visible = false
	
	if player_data.player_data["yellow"]:
		yellow.visible = true
	else:
		yellow.visible = false
	
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


func _on_start_body_entered(body):
	if body.is_in_group("player"):
		up = true


func _on_end_body_entered(body):
	if body.is_in_group("player"):
		up = false
		player_data.player_data["finished"] = true
		pl_gui.visible = true
		cam_gui.visible = false


func _on_death_plane_body_entered(body):
	if body.has_method("respawn"):
		body.respawn()
