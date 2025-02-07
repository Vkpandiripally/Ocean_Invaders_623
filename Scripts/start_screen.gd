extends CanvasLayer

func load_lore():
	get_tree().change_scene_to_file("res://Scenes/lore.tscn")

func exit():
	get_tree().quit()
