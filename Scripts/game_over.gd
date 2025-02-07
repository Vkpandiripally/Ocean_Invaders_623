extends CanvasLayer

@onready var game_over_container: CenterContainer = $MarginContainer/GameOverContainer

func _ready():
	MusicPlayer.stop_ocean_ost()
	AudioManager.GameEnd()
		
func on_game_lost():
	game_over_container.visible = true

func on_restart_button_pressed():
	AudioManager.MenuBoop()
	MusicPlayer.play_ocean_ost()
	
	get_tree().change_scene_to_file("res://Scenes/main.tscn")

func return_to_menu():
	AudioManager.MenuBoop()
	
	get_tree().change_scene_to_file("res://Scenes/start_screen.tscn")
