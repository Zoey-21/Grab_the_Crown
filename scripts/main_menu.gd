extends Node2D

const SAVE_FILE_NAME = "user://ngsettings.save"
onready var player_data = get_node("/root/PlayerData")
onready var api = get_node("/root/newgrowndapi")
onready var enable = $enable
onready var login = $login
var result
var passportUrl = null
var saveFile = File.new()
onready var time_played = get_node("/root/timeplayed")

func _ready():
	print($NewGroundsAPI.applicationId)
	time_played.stop()
	player_data.loading()
	Input.set_mouse_mode(0)
	_api_start()
	if !music.playing:
		music.play_music("res://resorces/music/Grab The Crown - Main Theme.wav",-12)



func _on_start_pressed():
	player_data.delete()
	player_data.player_data["postion"] = Vector2(397,258)
	get_tree().change_scene("res://menus/story_start.tscn")

func _on_load_pressed():
	print(player_data.player_data["map"])
#	if !player_data.player_data["map"] == "map":
	music.stop()
	get_tree().change_scene(player_data.player_data["map"])


func _on_fullscreen_pressed():
		OS.window_fullscreen = !OS.window_fullscreen

func _on_login_pressed():

	OS.shell_open(passportUrl)
	passportUrl = null
	$Label.text = 'Go and login via browser to connect user with session'
	$login.visible = false
	

func _write_save_file():
	api.save()

func _api_start():
	if saveFile.file_exists(SAVE_FILE_NAME):
		saveFile.open(SAVE_FILE_NAME, File.READ)
		var saveData = api.saveFile.get_var() # Dictionary
		saveFile.close()
		$NewGroundsAPI.session_id = api.saveData.sessionId
		$NewGroundsAPI.applicationId = api.saveData.applicationId
		if api.saveData.sessionId and api.saveData.sessionId.length() > 0:
			$Session.text = 'Session: To Check'
		if api.saveData.applicationId != null:
			$Value.text = api.saveData.applicationId
	$Label.text = ''
	$NewGroundsAPI.App.startSession()
	var result = yield($NewGroundsAPI, 'ng_request_complete')
	if $NewGroundsAPI.is_ok(result):
		$NewGroundsAPI.session_id = result.response.session.id
		passportUrl = result.response.session.passport_url
		$Login.disabled = false
		
		if result.response.session.expired:
			$Session.text = 'Session: Expired'
		else:
			$Session.text = 'Session: Valid'
			_write_save_file()
		
		if result.response.session.user:
			$User.text = result.response.session.user.name.to_lower()
		else:
			$User.text = 'User: '
	else:
		$Label.text = result.error
		$Session.text = 'Session: None'
		$User.text = 'User: '
	pass
	

func _on_checklog_pressed():
		$labal.text = ''
		$NewGroundsAPI.App.checkSession()
		var result = yield($NewGroundsAPI, 'ng_request_complete')
		if $NewGroundsAPI.is_ok(result):
			if result.response.session.expired:
				$Session.text = 'Session: Expired'
			else:
				$Session.text = 'Session: Valid'
			if result.response.session.user:
				$User.text = result.response.session.user.name.to_lower()
				enable.disabled = true
			else:
				$User.text = ' '
		else:
			$NewGroundsAPI.session_id = ''
			$labal.text = result.error
			passportUrl = null
			$login.disabled = true
			$Session.text = 'Session: None'
			$User.text = ''


func _on_credits2_pressed():
	$creditcam.current = true


func _on_credits3_pressed():
	$Camera2D.current = true


func _on_log_out_pressed():
	api.delete()
	$Label.text = ''
	$NewGroundsAPI.App.endSession()
	var result = yield($NewGroundsAPI, 'ng_request_complete')
	if $NewGroundsAPI.is_ok(result):
		$NewGroundsAPI.session_id = ''
		passportUrl = null
	else:
		$Label.text = result.error
	$Session.text = 'Session: None'
	$User.text = 'User: '
	enable.disabled = false
	
