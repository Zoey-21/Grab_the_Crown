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
	login.visible = false
	enable.visible = true
	OS.shell_open(passportUrl)
	passportUrl = null
	$lonin.disabled = true
	$labal.text = 'Go and login via browser to connect user with session'
	

func _write_save_file():
	api.save()

func _api_start():
	if saveFile.file_exists(SAVE_FILE_NAME):
		saveFile.open(SAVE_FILE_NAME, File.READ)
		var saveData = saveFile.get_var() # Dictionary
		saveFile.close()
		$NewGroundsAPI.session_id = saveData.sessionId
		$NewGroundsAPI.applicationId = saveData.applicationId
		if saveData.sessionId and saveData.sessionId.length() > 0:
			$sat.text = 'Session: To Check'
		$Value.text = saveData.applicationId
		
	$labal.text = ''
	$NewGroundsAPI.App.startSession()
	var result = yield($NewGroundsAPI, 'ng_request_complete')
	if $NewGroundsAPI.is_ok(result):
		$NewGroundsAPI.session_id = result.response.session.id
		passportUrl = result.response.session.passport_url
		$login.disabled = false
		
		if result.response.session.expired:
			$sat.text = 'Session: Expired'
		else:
			$sat.text = 'Session: Valid'
			_write_save_file()
		
		if result.response.session.user:
			$user.text =result.response.session.user.name + '[' + result.response.session.user.id + ']'
		else:
			$user.text = ' '
	else:
		$labal.text = result.error
		$sat.text = 'Session: None'
		$user.text = ''

func _on_checklog_pressed():
		$labal.text = ''
		$NewGroundsAPI.App.checkSession()
		var result = yield($NewGroundsAPI, 'ng_request_complete')
		if $NewGroundsAPI.is_ok(result):
			if result.response.session.expired:
				$sat.text = 'Session: Expired'
			else:
				$sat.text = 'Session: Valid'
			if result.response.session.user:
				$user.text = result.response.session.user.name.to_lower()
				enable.disabled = true
			else:
				$user.text = ' '
		else:
			$NewGroundsAPI.session_id = ''
			$labal.text = result.error
			passportUrl = null
			$login.disabled = true
			$sat.text = 'Session: None'
			$user.text = ''


func _on_credits2_pressed():
	$creditcam.current = true


func _on_credits3_pressed():
	$Camera2D.current = true
