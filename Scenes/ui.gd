extends CanvasLayer

var life_texture = preload("res://Assets/Player/Player.png")

@onready var lifes_ui_container = $MarginContainer/HBoxContainer
@onready var points_label = $MarginContainer/Points

@onready var points_counter = $"../PointsCounter" as PointsCounter
@onready var life_manager = $"../LifeManager" as LifeManager
@onready var invader_spawner = $"../InvaderSpawner" as InvaderSpawner

func _ready():
	points_label.text = "SCORE %d " % 0
	points_counter.on_points_increased.connect(points_increased)
	
func points_increased(points: int):
	points_label.text = "SCORE %d" % points
