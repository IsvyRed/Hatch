extends Marker2D
#STATE MACHINE FUNCTIONS

var BUS = preload("res://Gameplay Elements/Bossfight/Phase 1/phase_one_bus.tscn")
var PLAYER = preload("res://Gameplay Elements/player.tscn")
var dmgDealtRound = 0
var dmgDealtTotal
var exiting = false
var playerinst 

func enter(): #called on first pass AND when player dies and resets here
	Globals.sceneCamera.targetPos = Vector2(0,0)
	Globals.sceneCamera.position = Vector2(0,0)
	exiting = false
	dmgDealtTotal = 0
	dmgDealtRound = 0
	Globals.clearEnemies()
	playerinst = PLAYER.instantiate()
	playerinst.inBossfight = true
	add_child(playerinst)
	visible = true
	for tile in $ValidTiles.get_children():
		tile.set_collision_layer_value(1,true)
	for tile in $DeathTiles.get_children():
		tile.set_collision_layer_value(1,true)
	drop()
func update():
	pass
func exit():
	$ExitTimer.start()
	$Player.inCutscene = true
	#play boss anim, stop player from moving, switch scene on exit timer timeout


#PHASE ONE SPECIFIC FUNCTIONS
func drop(): # - ran when player hits space, should override standard enemy spawns
	$DamageDealt.text = "Damage dealt: " + str(dmgDealtTotal) + "/100"
	if dmgDealtTotal >= 10:
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


func _on_exit_timer_timeout():
	get_parent().progress()
	$Player.queue_free()
	for tile in $ValidTiles.get_children():
		tile.set_collision_layer_value(1,false)
	for tile in $DeathTiles.get_children():
		tile.set_collision_layer_value(1,false)
	visible = false
