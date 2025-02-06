extends CanvasLayer

@onready var game_over_container: CenterContainer = $MarginContainer/GameOverContainer
@onready var game_over_label: Label = %GameOverLabel
@onready var game_over_button: Button = %GameOverButton

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	game_over_button.pressed.connect(on_restart_button_pressed)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func on_game_lost():
	game_over_container.visible = true
	
func on_game_won():
	game_over_label.text = "You won!"
	game_over_label.add_theme_color_override("font_color", Color.GREEN)
	game_over_container.visible = true

func on_restart_button_pressed():
	get_tree().change_scene_to_file("res://Scenes/main.tscn")
