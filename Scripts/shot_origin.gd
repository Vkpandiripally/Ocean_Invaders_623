extends Node2D

@export var laser_scene: PackedScene
@export var net_scene: PackedScene
@export var can_move: int

var can_player_shoot = true
var can_shoot_net = true
var frozen = false

signal player_frozen

func _input(event):
	if Input.is_action_just_pressed("shoot") && can_player_shoot:
		can_player_shoot = false
		var laser = laser_scene.instantiate() as Laser
		laser.global_position = get_parent().global_position - Vector2(0,20)
		get_tree().root.get_node("main").add_child(laser)
		laser.tree_exited.connect(on_laser_destoryed)
		
	if Input.is_action_just_pressed("shoot_net") && can_shoot_net:
		can_shoot_net = false
		emit_signal("player_frozen")
		var net = net_scene.instantiate() as Net
		net.global_position = get_parent().global_position - Vector2(0,20)
		get_tree().root.get_node("main").add_child(net)
		net.tree_exited.connect(on_net_destroyed)

func on_laser_destoryed():
	if (not frozen):
		can_player_shoot = true
	
func on_net_destroyed():
	if (not frozen):
		can_shoot_net = true

func _on_player_frozen() -> void:
	can_shoot_net = false
	can_player_shoot = false
	frozen = true

func _on_player_player_unfrozen() -> void:
	can_shoot_net = true
	can_player_shoot = true
	frozen = false
