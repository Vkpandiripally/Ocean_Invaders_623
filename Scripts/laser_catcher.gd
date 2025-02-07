extends Area2D

@export var net_scene: PackedScene

func _on_area_entered(area):
	if area is Net:
		var caught_net = net_scene.instantiate() as CaughtNet
		caught_net.position = area.position - Vector2(0,20)
		var root_node = get_tree().root.get_node("main")
		root_node.call_deferred("add_child", caught_net)
	area.queue_free()
