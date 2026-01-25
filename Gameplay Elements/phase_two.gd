extends Marker2D
var PLAYER = preload("res://Gameplay Elements/player.tscn")
var PLATFORM = preload("res://Gameplay Elements/Bossfight/Phase 2/phase_two_platform.tscn")
var playerinst
var queuedPlatformX = 1600
var damageTaken = 0
var skipEnemyChance = 1 #set by platforms
var curlane = 1
var scrolling = true
#STATE MACHINE FUNCTIONS
func enter():
	curlane = 1
	Globals.clearEnemies()
	#skipped platforms behind and stacked w/ player, i know this code looks hideous dont mention it ot me
	var initPlatforms = [$PhaseTwoPlatform5,$PhaseTwoPlatform6,$PhaseTwoPlatform7,$PhaseTwoPlatform8,$PhaseTwoPlatform9]
	for platform in initPlatforms:
		if platform:
			platform.spawnEnemy(curlane)
	playerinst = PLAYER.instantiate()
	playerinst.position.x = 400
	playerinst.inBossfight = true
	add_child(playerinst)
	visible = true
func update(): #start moving scene camera by changing its targetPos property
	if scrolling:
		Globals.sceneCamera.targetPos.x += 4
func exit(): #on win
	scrolling = false
	$ExitTimer.start()

#OTHER FUNCTIONS
func spawnPlatform(platform):
	if damageTaken >= 10:
		exit()
	platform.position.x = queuedPlatformX
	queuedPlatformX += 200
	$DeathTile.position.x += 200
	$DeathTile2.position.x += 200
	$DeathTile3.position.x += 200
	platform.spawnEnemy(curlane) #curlane can be changed by platform instance 

func playerDied():
	#play death anim w/ game paused and then call parent's playerdied func
	get_parent().resetTimer.start()
	get_tree().paused = true
	$Player.queue_free()

func _on_exit_timer_timeout():
	Globals.sceneCamera.targetPos = Vector2(0,0)
	Globals.sceneCamera.position = Vector2(0,0)
	get_parent().progress()
	queue_free()
