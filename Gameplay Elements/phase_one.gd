extends Marker2D
#STATE MACHINE FUNCTIONS

var BUS = preload("res://Gameplay Elements/Bossfight/Phase 1/phase_one_bus.tscn")
var PLAYER = preload("res://Gameplay Elements/player.tscn")
var dmgDealtRound = 0
var dmgDealtTotal
var exiting = false
var playerinst 

func enter(): #called on first pass AND when player dies and resets here
	$Boss.play()
	$Platform.play()
	$IntroTimer.start() #used to spawn player after boss intro
	Globals.sceneCamera.targetPos = Vector2(0,0)
	Globals.sceneCamera.position = Vector2(0,0)
	exiting = false
	dmgDealtTotal = 0
	dmgDealtRound = 0
	Globals.clearEnemies()
	
	visible = true
	for tile in $ValidTiles.get_children():
		tile.set_collision_layer_value(1,true)
	for tile in $DeathTiles.get_children():
		tile.set_collision_layer_value(1,true)
	
func update():
	pass
func exit():
	#$ExitTimer.start() -- unused now, replaced by boss animation ending
	$Player.inCutscene = true
	
	#play boss anim, stop player from moving, switch scene on exit timer timeout
	$Boss.animation = "death"
	$Boss.play()
	get_parent().camera.moveBy(Vector2(0,-600),0.3)
	Globals.clearEnemies()


#PHASE ONE SPECIFIC FUNCTIONS
func drop(): # - ran when player hits space, should override standard enemy spawns
	if dmgDealtTotal >= 10: #----------------------------------------------------DAMAGE NEEDED TO PROGRESS
		exit()
		exiting = true
	if not exiting:
		var newBus = BUS.instantiate()
		Globals.clearEnemies()
		newBus.position = $Player.position
		add_child(newBus)
		Globals.floor += 1
		
func playerDied():
	#play death anim w/ game paused and then start the parent's reset timer
	get_parent().resetTimer.start()
	get_tree().paused = true
	$Player.queue_free()
	

func timeout():
	#Play boss taking damage animation
	if not exiting:
		if dmgDealtRound >= 6 and Globals.enemiesLeft == 1:
			dmgDealtTotal += dmgDealtRound
			drop()
		else:
			playerDied()
		dmgDealtRound = 0


func _on_exit_timer_timeout(): #now called by boss animation finishing
	get_parent().progress()
	$Player.queue_free()
	for tile in $ValidTiles.get_children():
		tile.set_collision_layer_value(1,false)
	for tile in $DeathTiles.get_children():
		tile.set_collision_layer_value(1,false)
	visible = false


func _on_intro_timer_timeout():
	playerinst = PLAYER.instantiate()
	playerinst.inBossfight = true
	add_child(playerinst)
	drop()


func _on_boss_animation_finished():
	if	$Boss.animation == "transition":
		_on_exit_timer_timeout() #-- replaces exit timer
	if $Boss.animation == "death":
		$Boss.animation = "transition"
		$Boss.play()
		$Boss.position = Vector2(-2000,-150)
		get_parent().camera.moveBy(Vector2(-2000,600),0.5)
		$RecenterTimer.start()
	
		
func _on_recenter_timer_timeout():
	$Platform.visible = false
	Globals.player.visible = false
	$Boss.position = Vector2(0,0)
	get_parent().camera.position = Vector2(0,150)
	get_parent().camera.targetPos = Vector2(0,150)
