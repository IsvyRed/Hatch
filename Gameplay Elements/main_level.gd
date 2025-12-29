extends Node2D
var towerSprites = [preload("res://Sprites/TowerA.png"),preload("res://Sprites/TowerB.png"),preload("res://Sprites/TowerC.png"),preload("res://Sprites/TowerD.png"),preload("res://Sprites/TowerE.png")]


func drop():
	$DropAnim.visible = true
	$DropAnim.play()
	$Tower.texture = towerSprites.pick_random()
	$ParallaxBG.dropLevel()

func _on_drop_anim_animation_finished():
	$DropAnim.visible = false
