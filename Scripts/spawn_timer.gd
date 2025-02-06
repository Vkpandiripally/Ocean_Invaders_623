extends Timer

class_name SpawnTimer

@export var min_time = 5
@export var max_timer = 10

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	setup_timer()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func setup_timer():
	var random_time = randi_range(min_time, max_timer)
	self.wait_time = random_time
	self.stop()
	self.start()
