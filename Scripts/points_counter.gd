extends Node

class_name PointsCounter

signal on_points_increased(points: int)
signal friendly_destroyed

var points = 0

@onready var invader_spawner = $"../InvaderSpawner" as InvaderSpawner

func _ready():
	invader_spawner.invader_destroyed.connect(increase_points)
	invader_spawner.friendly_destroyed.connect(multiply_points)
	
func increase_points(points_to_add: int):
	points += points_to_add
	on_points_increased.emit(points)

func multiply_points(is_net: bool):
	if (is_net):
		points += abs(points) 
		on_points_increased.emit(points)
	else:
		points -= 100
	on_points_increased.emit(points)
