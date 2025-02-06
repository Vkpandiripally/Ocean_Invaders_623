extends Area2D
class_name Player

signal player_destroyed
signal player_unfrozen

var lives = 2
var speed = 300
var direction = Vector2.ZERO
@onready var collision_rect: CollisionShape2D = $CollisionShape2D
@onready var animation_player = $AnimationPlayer
var start_bound
var end_bound
var can_move = true
var bounding_x

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	bounding_x = collision_rect.shape.get_rect().size.x
	var rect = get_viewport().get_visible_rect()
	var camera = get_viewport().get_camera_2d()
	var camera_pos = camera.position
	start_bound = ((camera_pos.x - rect.size.x) /2) 
	end_bound =  ((camera_pos.x + rect.size.x) /2)  

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var input = Input.get_axis("move_left","move_right")
	
	if input > 0:
		direction = Vector2.RIGHT
	elif input < 0:
		direction = Vector2.LEFT
	else:
		direction = Vector2.ZERO
	
	var delta_movement = speed*delta*direction.x
	
	#making sure we dont go out of bounds
	if (position.x + delta_movement < start_bound + bounding_x * transform.get_scale().x || position.x + delta_movement > end_bound - bounding_x * transform.get_scale().x):
		return
	if (not can_move):
		return
	position.x += delta_movement
				
func _on_animation_player_animation_finished(anim_name):
	if anim_name == "destroy":
		await get_tree().create_timer(1).timeout
		player_destroyed.emit()
		queue_free()
		
func _on_area_entered(area: Area2D) -> void:
	if area is CaughtNet:
		area.queue_free()
		emit_signal("player_unfrozen")

func _on_shot_origin_player_frozen() -> void:
	can_move = false

func _on_player_unfrozen() -> void:
	can_move = true
