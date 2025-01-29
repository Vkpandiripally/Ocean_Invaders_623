extends Node2D

class_name InvaderSpawner

#spawner configs
const ROWS=5
const COLUMNS=11
const HORIZONTAL_SPACING=45
const VERTICAL_SPACING=32
const INVADER_HEIGHT=24
const START_Y_POSITION=-100
const INVADERS_POSITION_X_INCREMENT=18
const INVADERS_POSITION_Y_INCREMENT=20

var movement_direction = 1
var invader_scene = preload("res://Scenes/invader.tscn")

#NODE REFERENCES
@onready var movement_timer = $MovementTimer


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#set up timers
	movement_timer.timeout.connect(move_invaders)
	var invader1_res = preload("res://Resources/invader1.tres")
	var invader2_res = preload("res://Resources/invader2.tres")
	var invader3_res = preload("res://Resources/invader3.tres")
	
	
	var invader_config
	for row in ROWS:
		if row == 0:
			invader_config = invader1_res
		elif row == 1 || row == 2:
			invader_config = invader2_res
		elif row == 3 || row == 4:
			invader_config = invader3_res
			
		var row_width = (COLUMNS + invader_config.width*3) + ((COLUMNS-1) * HORIZONTAL_SPACING)
		var start_x = (position.x - row_width) / 2
		#var start_x = -535 #idk this isnt right. Need a better way to center the spawn point
		
		for col in COLUMNS:
			var x = (start_x + (col * invader_config.width*3) + (col * HORIZONTAL_SPACING))-200 
			var y = START_Y_POSITION + (row * INVADER_HEIGHT) + (row * VERTICAL_SPACING)
			var spawn_start = Vector2(x,y)
			spawn_invader(invader_config,spawn_start)
func spawn_invader(invader_config, spawn_position: Vector2):
	var invader = invader_scene.instantiate() as Invader
	invader.config = invader_config
	invader.global_position = spawn_position
	add_child(invader)
	
func move_invaders():
	position.x += INVADERS_POSITION_X_INCREMENT * movement_direction

#this function connected via signal to the left wall in the main scene. However it doesnt work. Around 1:40:00 in the tutorial
#when invaders hit wall, they should move closer to player and move in opposite direction.
#Currently, invaders just go off screen. No collision with wall. Problem for left and right wall. 
#Harrison 1/29/25 5:32pm
func _on_left_wall_area_entered(area: Area2D) -> void:
	if (movement_direction == -1):
		position.y += INVADERS_POSITION_Y_INCREMENT
		movement_direction *= -1

#same issue as left wall. This function is connected via signal to right wall in main scene. Does not work
func _on_right_wall_area_entered(area: Area2D) -> void:
	if (movement_direction == 1):
		position.y += INVADERS_POSITION_Y_INCREMENT
		movement_direction *= -1
