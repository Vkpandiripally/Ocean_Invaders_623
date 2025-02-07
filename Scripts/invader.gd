extends Area2D

class_name Invader

signal invader_destroyed(points: int)

@export var net_scene: PackedScene

@onready var sprite_2d = $Sprite2D
@onready var animation_player = $AnimationPlayer
var config: Resource

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	sprite_2d.texture = config.sprite
	animation_player.play(config.animation_name)

func _on_area_entered(area: Area2D) -> void:
	if area is Laser:
		AudioManager.EnemyHit()
		area.queue_free()
		queue_free()
		invader_destroyed.emit(config.points)
	if area is Net:
		AudioManager.EnemyHitNet()
		var caught_net = net_scene.instantiate() as CaughtNet
		caught_net.position = area.position - Vector2(0,20)
		var root_node = get_tree().root.get_node("main")
		root_node.call_deferred("add_child", caught_net)
		area.queue_free()
		queue_free()
		invader_destroyed.emit(-1 * config.points)
