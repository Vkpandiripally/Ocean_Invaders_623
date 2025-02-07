extends Area2D
class_name InvaderShot
@export var speed = 200

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	position.y += speed * delta

func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	queue_free()

func _on_area_entered(area: Area2D) -> void:
	if area is Player:
		AudioManager.PlayerHit()
		var life_manager = get_node("../main/LifeManager") as LifeManager
		life_manager.on_player_destroyed()
		queue_free()
		
func _ready():
	AudioManager.InvaderShot()
	add_to_group("invader_shots")
