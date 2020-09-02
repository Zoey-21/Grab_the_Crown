extends Node

var save_path = "user://save.dat"

var player_data_default = {
	"gun" : 0,
	"light" : false,
	"gloves" : false,
	"g-nades" : false,
	"g-nades_out" : 0,
	
	"red" : false,
	"blue" : false,
	"yellow" : false,
	"crown" : false,
	
	"health" : 3,
	
	"postion_save" : Vector2(0,0),
	"map" : "map",
	
	"shootable" : false,
	"can_climb" : false,

	"gun1" : false,
	"gun2" : false,
	"gun3" : false,
	
	"collapsing" : false,
	"timer_started" : false,
	"finished" : false,
	
	"time_played": 0,
	}

var player_data = {
	"gun" : 0,
	"light" : false,
	"gloves" : false,
	"g-nades" : false,
	"g-nades_out" : 0,
	"red" : false,
	"blue" : false,
	"yellow" : false,
	"crown" : false,
	
	"health" : 3,
	
	"postion_save" : Vector2(0,0),
	"map" : "map",
	
	"shootable" : false,
	"can_climb" : false,

	"gun1" : false,
	"gun2" : false,
	"gun3" : false,
	
	"collapsing" : false,
	"timer_started" : false,
	"finished" : false,
	
	"time_played": 0,
	}

func save():
	
	var file = File.new()#makes a new file for saveing
	var error = file.open(save_path, File.WRITE)#opens file to write to
	if error == OK:# makes sure file loaded corectly
		file.store_var(player_data)#stores info to file
		file.close()#stops wrighting to file
	else:
		print(error)

func loading():
	var file = File.new()#loads file 
	if file.file_exists(save_path):# if file exists
		var error = file.open(save_path, File.READ)#file gets read
		if error == OK:
			var levels = file.get_var()
			file.close()
			player_data = levels
		else:
			print(error)

func delete():
	player_data = player_data_default #sets eveything to false
	var file = File.new()#makes a new file for saveing
	var error = file.open(save_path, File.WRITE)#opens file to write to
	if error == OK:# makes sure file loaded corectly
		file.store_var(player_data)#stores info to file
		file.close()#stops wrighting to file
	else:
		print(error)


