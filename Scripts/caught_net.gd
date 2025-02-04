extends Area2D

class_name CaughtNet

var speed = 800

func _process(delta):
	var root_node = get_parent()
	var pos = root_node.get_node("Player").position
	var pos2 = Vector2(0, 30)
	look_at(pos)
	position += transform.x * speed * delta
