extends Line2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var root_node = get_parent().get_parent()
	var pos1 = Vector2(root_node.get_node("Player").global_position.x, 302) - self.global_position
	var pos2 = Vector2(0, 30)
	points = [pos1, pos2]
