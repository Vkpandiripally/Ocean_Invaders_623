extends Node2D
#script for shooting
@export var laser_scene: PackedScene
var can_player_shoot = true
@onready var player = get_parent() as Player  # Get reference to the player

func _input(event):
	if Input.is_action_just_pressed("shoot") && can_player_shoot && player.lives > 0:
		can_player_shoot = false
		var laser = laser_scene.instantiate() as Laser
		laser.global_position = get_parent().global_position - Vector2(0,20)
		get_tree().root.get_node("main").add_child(laser)
		laser.tree_exited.connect(on_laser_destoryed)

func on_laser_destoryed():
	can_player_shoot = true
