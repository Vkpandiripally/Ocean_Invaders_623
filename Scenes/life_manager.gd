extends Node

class_name LifeManager

signal life_lost(lifes_left: int)

@export var lives = 3
@onready var player: Player = $"../Player"
var player_scene = preload("res://Scenes/player.tscn")

func _ready():
	print("Life manager is ready")
	(player as Player).player_destroyed.connect(on_player_destroyed)
	
func on_player_destroyed():
	lives -= 1
	print("Player destroyed! Remaining lives:", lives)  # Debug check
	life_lost.emit(lives)
	if lives == 2:
		player.animation_player.play("2_lives")
	elif lives ==1:
		player.animation_player.play("1_life")
	elif lives == 0:
		player.animation_player.play("dead")
