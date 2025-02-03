extends Area2D
class_name Player

signal player_destroyed 

#var lives = 3
var speed = 200
var direction = Vector2.ZERO
@onready var collision_rect: CollisionShape2D = $CollisionShape2D
@onready var animation_player = $AnimationPlayer
var start_bound
var end_bound
@export var lives = 2
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
	
func on_player_destroyed():
	if lives == 2:
		animation_player.play("2_lives")
		print("2 lives left")
		lives -= 1
	elif lives == 1:
		animation_player.play("1_life")
		print("1 life left")
		lives -= 1
	elif lives ==0:
		animation_player.play("player_destroy")
		speed = 0
		lives -= 1 
	#elif lives == 0:
	#	animation_player.play("dead")
	#	print("dead")
	#	speed = 0
	else:
		print(lives)
	#speed = 0
	#animation_player.play("player_destroy")
				
func _on_animation_player_animation_finished(anim_name):
	if anim_name == "destroy":
		await get_tree().create_timer(1).timeout
		player_destroyed.emit()
		queue_free()
	
