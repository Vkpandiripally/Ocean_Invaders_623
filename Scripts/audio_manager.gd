extends Node

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

func LoreRadar():
	$LoreRadar.play()

func MenuBoop():
	$MenuBoop.play(0.34)

func PlayerHit():
	$PlayerHit.play(1.05)
