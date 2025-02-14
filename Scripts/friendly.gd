extends Area2D

class_name Friendly

signal friendly_destroyed(is_net: bool)

@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D
var config: Resource

@export var net_scene: PackedScene

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	sprite_2d.texture = config.sprite

func _on_area_entered(area: Area2D) -> void:
	if area is Laser:
		AudioManager.FriendlyHit()
		area.queue_free()
		queue_free()
		friendly_destroyed.emit(false)
		
	if area is Net:
		AudioManager.FriendlyCaught()
		var caught_net = net_scene.instantiate() as CaughtNet
		caught_net.position = area.position - Vector2(0,20)
		var root_node = get_tree().root.get_node("main")
		root_node.call_deferred("add_child", caught_net)
		area.queue_free()
		queue_free()
		friendly_destroyed.emit(true)
