extends Node2D

class_name InvaderSpawner

#spawner configs
const ROWS=5
const COLUMNS=11
const HORIZONTAL_SPACING=32
const VERTICAL_SPACING=32
const INVADER_HEIGHT=24
const START_Y_POSITION=-50
const INVADERS_POSITION_X_INCREMENT=10
const INVADERS_POSITION_Y_INCREMENT=20

var movement_direction = 1


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
