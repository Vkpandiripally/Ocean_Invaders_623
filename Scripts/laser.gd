extends Area2D

class_name Laser

var speed = 300

func _process(delta):
	position.y -= delta * speed
