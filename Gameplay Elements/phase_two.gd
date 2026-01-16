extends Marker2D
var PLAYER = preload("res://Gameplay Elements/player.tscn")
var PLATFORM = preload("res://Gameplay Elements/Bossfight/Phase 2/phase_two_platform.tscn")
var playerinst
var queuedPlatformX = 1600
#STATE MACHINE FUNCTIONS
func enter():
	playerinst = PLAYER.instantiate()
	playerinst.spawnEnemies = false
	playerinst.dieOnTimeout = false
	playerinst.dieOnMiss = false
	add_child(playerinst)
	visible = true
	print("ENTER PHASE 2")
func update(): #start moving scene camera by changing its targetPos property
	Globals.sceneCamera.targetPos.x += 2
func exit():
	Globals.sceneCamera.targetPos = Vector2(0,0)
	get_parent().progress()
#OTHER FUNCTIONS
func spawnPlatform():
	var platforminst = PLATFORM.instantiate()
	platforminst.position.x = queuedPlatformX
	queuedPlatformX += 200
	add_child(platforminst)
