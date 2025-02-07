extends CanvasLayer

func _ready():
	AudioManager.LoreRadar()
	
func load_game():
	AudioManager.MenuBoop()
	
	get_tree().change_scene_to_file("res://Scenes/main.tscn")
