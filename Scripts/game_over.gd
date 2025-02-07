extends CanvasLayer

@onready var game_over_container: CenterContainer = $MarginContainer/GameOverContainer

func on_game_lost():
	game_over_container.visible = true

func on_restart_button_pressed():
	get_tree().change_scene_to_file("res://Scenes/main.tscn")

func exit():
	get_tree().quit()
