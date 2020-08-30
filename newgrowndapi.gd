extends Node

const SAVE_FILE_NAME = "user://ngsettings.save"
var saveFile = File.new()

var saveDatadefalt = {
		applicationId = null,
		sessionId = null
}

var saveData = {
		applicationId = null,
		sessionId = null
}


func save():
	
	var error = saveFile.open(SAVE_FILE_NAME, File.WRITE)
	if error == OK:
		saveData.sessionId = $NewGroundsAPI.session_id
		saveData.applicationId = $NewGroundsAPI.applicationId
		saveFile.store_var(saveData)
		saveFile.close()
	else:
		print('Fail save file')
	pass

func loading():
	var file = File.new()#loads file 
	if file.file_exists(SAVE_FILE_NAME):# if file exists
		var error = file.open(SAVE_FILE_NAME, File.READ)#file gets read
		if error == OK:
			var levels = file.get_var()
			file.close()
			saveData = levels
		else:
			print(error)

func delete():
	saveData = saveDatadefalt #sets eveything to false
	var file = File.new()#makes a new file for saveing
	var error = file.open(SAVE_FILE_NAME, File.WRITE)#opens file to write to
	if error == OK:# makes sure file loaded corectly
		file.store_var(saveData)#stores info to file
		file.close()#stops wrighting to file
	else:
		print(error)


