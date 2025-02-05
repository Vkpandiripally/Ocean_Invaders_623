extends Node2D

class_name InvaderSpawner

signal invader_destroyed(points: int)
signal friendly_destroyed(is_net: bool)
signal game_won
signal game_lost

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
var invader_shot_scene = preload("res://Scenes/invader_shot.tscn")
var friendly_scene = preload("res://Scenes/friendly.tscn")

var invader_destroyed_count = 0
var invader_total_count = ROWS * COLUMNS

#NODE REFERENCES
@onready var movement_timer = $MovementTimer
@onready var shot_timer = $ShotTimer
#@onready var life_manager = $"../LifeManager"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#stop invaders after death
	#life_manager.game_lost.connect(on_game_lost)
	
	#set up timers
	movement_timer.timeout.connect(move_invaders)
	shot_timer.timeout.connect(on_invader_shot)
	
	var invader1_res = preload("res://Resources/invader1.tres")
	var invader2_res = preload("res://Resources/invader2.tres")
	var invader3_res = preload("res://Resources/invader3.tres")
	var friendly_res = preload("res://Resources/friendly.tres")
	
	
	var invader_config
	var friendly_config
	
	friendly_config = friendly_res
	
	var friendly_row = randi() % ROWS
	var friendly_col = randi() % COLUMNS
	
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
			#spawn_invader(invader_config,spawn_start)
		
			# spawn friendly or invader
			if row == friendly_row and col == friendly_col:
				spawn_friendly(friendly_config, spawn_start)
			else:
				spawn_invader(invader_config, spawn_start)
			
func spawn_invader(invader_config, spawn_position: Vector2):
	var invader = invader_scene.instantiate() as Invader
	invader.config = invader_config
	invader.global_position = spawn_position
	invader.invader_destroyed.connect(on_invader_destroyed)
	add_child(invader)
	
func move_invaders():
	position.x += INVADERS_POSITION_X_INCREMENT * movement_direction
	
func spawn_friendly(friendly_config, spawn_position: Vector2):
	var friendly = friendly_scene.instantiate() as Friendly
	friendly.config = friendly_config
	friendly.global_position = spawn_position
	friendly.friendly_destroyed.connect(on_friendly_destroyed)
	add_child(friendly)

func _on_left_wall_area_entered(area: Area2D) -> void:
	if (movement_direction == -1):
		position.y += INVADERS_POSITION_Y_INCREMENT
		movement_direction *= -1

func _on_right_wall_area_entered(area: Area2D) -> void:
	if (movement_direction == 1):
		position.y += INVADERS_POSITION_Y_INCREMENT
		movement_direction *= -1
		
func on_invader_shot():
	var random_child_position = get_children().filter(func (child): return child is Invader).map(func(Invader): return Invader.global_position).pick_random()
	var invader_shot = invader_shot_scene.instantiate() as InvaderShot
	invader_shot.global_position = random_child_position
	get_tree().root.add_child(invader_shot)
	
func on_invader_destroyed(points: int):
	invader_destroyed.emit(points)
	invader_destroyed_count += 1
	
	if invader_destroyed_count == invader_total_count:
		game_won.emit()
		shot_timer.stop()
		movement_timer.stop()

func on_friendly_destroyed(is_net: bool):
	friendly_destroyed.emit(is_net)
	if !is_net:
		var life_manager = get_node("../LifeManager") as LifeManager
		if life_manager:
			life_manager.on_player_destroyed()
		else:
			print("Life manager not called")
		
func _on_bottom_wall_area_entered(area):
	game_lost.emit()
	movement_timer.stop()
	movement_direction = 0

func on_game_lost():
	movement_timer.stop()
	movement_direction = 0
