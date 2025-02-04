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
		animation_player.play("destroy")
		area.queue_free()
	if area is Net:
		var caught_net = net_scene.instantiate() as CaughtNet
		caught_net.position = area.position - Vector2(0,20)
		var root_node = get_tree().root.get_node("main")
		root_node.call_deferred("add_child", caught_net)
		area.queue_free()
		queue_free()
		invader_destroyed.emit(-1 * config.points)
	
func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name == "destroy":
		queue_free()
		invader_destroyed.emit(config.points)
