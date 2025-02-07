extends AudioStreamPlayer

const game_music = preload("res://Assets/Sounds/Ocean Intruders OST.mp3")

func _play_music(music: AudioStream, volume = -5.0):
	if stream == music:
		return
	
	stream = music
	volume_db = volume
	play()

func play_ocean_ost():
	_play_music(game_music)

func stop_ocean_ost():
	stop()
	stream = null
