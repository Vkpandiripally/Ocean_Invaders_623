extends Node

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func EnemyHit():
	$EnemyHit.play(0.90)

func GameEnd():
	$GameEnd.play(0.48)
	
func EnemyHitNet():
	$EnemyHitNet.play(0.66)

func InvaderShot():
	$InvaderShot.play(0.02)
	
func FriendlyCaught():
	$FriendlyCaught.play(0.46)

func FriendlyHit():
	$FriendlyHit.play(0.97)

func WaveEnd():
	$WaveEnd.play(0.36)

func MenuBoop():
	$MenuBoop.play(0.34)
