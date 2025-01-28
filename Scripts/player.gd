extends Area2D

var speed = 200
var direction = Vector2.ZERO
@onready var collision_rect: CollisionShape2D = $CollisionShape2D
var start_bound
var end_bound

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
	position.x += delta_movement
				
