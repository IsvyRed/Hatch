extends Marker2D
var PLAYER = preload("res://Gameplay Elements/player.tscn")
var PLATFORM = preload("res://Gameplay Elements/Bossfight/Phase 2/phase_two_platform.tscn")
var playerinst
var queuedPlatformX = 1600
var damageTaken = 0
var skipEnemyChance = 1 #set by platforms
var curlane = 1
#STATE MACHINE FUNCTIONS
func enter():
	#skipped platforms behind and stacked w/ player, i know this code looks hideous dont mention it ot me
	var initPlatforms = [$PhaseTwoPlatform5,$PhaseTwoPlatform6,$PhaseTwoPlatform7,$PhaseTwoPlatform8,$PhaseTwoPlatform9]
	for platform in initPlatforms:
		platform.spawnEnemy(curlane)
	playerinst = PLAYER.instantiate()
	playerinst.position.x = 400
	playerinst.spawnEnemies = false
	playerinst.dieOnTimeout = false
	playerinst.dieOnMiss = false
	add_child(playerinst)
	visible = true
	print("ENTER PHASE 2")
func update(): #start moving scene camera by changing its targetPos property
	Globals.sceneCamera.targetPos.x += 4
func exit():
	Globals.sceneCamera.targetPos = Vector2(0,0)
	get_parent().progress()
#OTHER FUNCTIONS
func spawnPlatform():
	if damageTaken >= 200:
		get_parent().progress()
		queue_free()
	var platforminst = PLATFORM.instantiate()
	platforminst.position.x = queuedPlatformX
	queuedPlatformX += 200
	$DeathTile.position.x += 200
	$DeathTile2.position.x += 200
	$DeathTile3.position.x += 200
	add_child(platforminst)
	platforminst.spawnEnemy(curlane) #curlane can be changed by platform instance 
