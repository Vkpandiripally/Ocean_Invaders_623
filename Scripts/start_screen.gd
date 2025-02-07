extends CanvasLayer

func _ready():
	MusicPlayer.play_ocean_ost()
	
func load_lore():
	AudioManager.MenuBoop()
	
	get_tree().change_scene_to_file("res://Scenes/lore.tscn")

func exit():
	get_tree().quit()
