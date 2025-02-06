extends CanvasLayer

var life_texture = preload("res://Assets/Player/Player.png")

@onready var lifes_ui_container = $MarginContainer/HBoxContainer
@onready var points_label = $MarginContainer/Points

@onready var points_counter = $"../PointsCounter" as PointsCounter
@onready var life_manager = $"../LifeManager" as LifeManager
@onready var invader_spawner = $"../InvaderSpawner" as InvaderSpawner
#@onready var game_over_label: Label = %GameOverLabel
#@onready var game_over_button: Button = %GameOverButton
#@onready var game_over_container: CenterContainer = $MarginContainer/GameOverContainer

var global_lives = 5
func _ready():
	if global_lives <= 0:
		pass
	else:
		if life_manager == null:
			print("ERROR: life_manager is NULL!")
		else:
			print("LifeManager found! Connecting signal...")
			life_manager.life_lost.connect(on_lifes_lost)
			
		points_label.text = "SCORE %d " % 0
		points_counter.on_points_increased.connect(points_increased)
		
		for i in range(life_manager.lifes):
			var life_texture_rect = TextureRect.new()
			life_texture_rect.expand_mode = TextureRect.EXPAND_KEEP_SIZE
			life_texture_rect.custom_minimum_size = Vector2(40, 25)
			life_texture_rect.texture_filter = CanvasItem.TEXTURE_FILTER_NEAREST
			life_texture_rect.texture = life_texture
			lifes_ui_container.add_child(life_texture_rect)
	
func points_increased(points: int):
	points_label.text = "SCORE %d" % points

func on_lifes_lost(lifes_left: int):
	print("Lifes Left:", lifes_left)  # Debugging output
	global_lives = lifes_left
	if lifes_left >= 0:
		var life_texture_rect = lifes_ui_container.get_child(lifes_left)
		life_texture_rect.queue_free()
	
	if lifes_left == 0:
		invader_spawner.game_over()
