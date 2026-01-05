extends Node2D
var towerSprites = [preload("res://Sprites/TowerA.png"),preload("res://Sprites/TowerB.png"),preload("res://Sprites/TowerC.png"),preload("res://Sprites/TowerD.png"),preload("res://Sprites/TowerE.png")]
var LASTFLOORSCENE = load("res://Gameplay Elements/last_floor.tscn")
var endParallaxRate = 1
func _ready():
	$ParallaxBG.dropLevel()
	Globals.forceDifficulty()
	set_physics_process(false)
	
func _physics_process(_delta):
	endParallaxRate += 0.35
	$ParallaxBG.dropLevel(endParallaxRate) 

func drop():
	endParallaxRate = Globals.floor
	$DropAnim.visible = true
	$DropAnim.play()
	$Tower.texture = towerSprites.pick_random()
	$ParallaxBG.dropLevel()
	if Globals.floor == 150: #SET TO 65 FOR 66 FLOOR ENDING
		lastFloorReached()

func _on_drop_anim_animation_finished():
	$DropAnim.visible = false

func lastFloorReached():
	Globals.clearEnemies()
	set_physics_process(true)
	$EndLevelTimer.start()
	$DropAnim.visible = true
	$DropAnim.animation = "level_end"
	$DropAnim.play()
	Globals.player.stopTimer()
	Globals.player.endLevel()


func _on_end_level_timer_timeout():
	var lastFloor = LASTFLOORSCENE.instantiate()
	add_sibling(lastFloor)
	Globals.resetRun(false)
	Globals.onScreenTimer.queue_free()
	queue_free()
