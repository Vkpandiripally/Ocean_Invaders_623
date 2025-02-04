extends Area2D

class_name Net

var speed = 800

func _process(delta):
	position.y -= delta * speed
