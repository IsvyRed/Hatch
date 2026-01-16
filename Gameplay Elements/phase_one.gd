extends Marker2D
#STATE MACHINE FUNCTIONS

var BUS = preload("res://Gameplay Elements/Bossfight/Phase 1/phase_one_bus.tscn")
var dmgDealtRound = 0
var dmgDealtTotal = 0
var exiting = false
func _ready():
	$Player.set_process(false)

func enter():
	$Player.set_process(true)
	$Player.spawnEnemies = false
	$Player.dieOnTimeout = false
	$Player.dieOnMiss = false
func update():
	pass
func exit():
	$ExitTimer.start()
	#play boss anim, stop player from moving, switch scene on exit timer timeout


#PHASE ONE SPECIFIC FUNCTIONS
func drop(): # - ran when player hits space, should override standard enemy spawns
	$DamageDealt.text = "Damage dealt: " + str(dmgDealtTotal) + "/10"
	if dmgDealtTotal >= 10:
		exit()
		exiting = true
	if not exiting:
		var newBus = BUS.instantiate()
		Globals.clearEnemies()
		newBus.position = $Player.position
		add_child(newBus)
		Globals.floor += 1

func timeout():
	#Play boss taking damage animation
	if not exiting:
		if dmgDealtRound >= 6 and Globals.enemiesLeft == 1:
			dmgDealtTotal += dmgDealtRound
			drop()
		else:
			get_parent().lives -= 1
			#player taking damage animation here
			drop()
			if get_parent().lives == 0:
				#force player death
				$Player.dieOnMiss = true
				$Player.missedEnemy() 
		dmgDealtRound = 0


func _on_exit_timer_timeout():
	get_parent().progress()
	queue_free()
