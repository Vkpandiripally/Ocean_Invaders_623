extends Area2D

class_name Laser

var speed = 600

func _ready():
	add_to_group("lasers")
	
func _process(delta):
	position.y -= delta * speed
