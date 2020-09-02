extends AudioStreamPlayer


func play_music(audio,vol):
	audio = load(audio)
	self.set_stream(audio)
	self.set_volume_db(vol)
	self.play()
