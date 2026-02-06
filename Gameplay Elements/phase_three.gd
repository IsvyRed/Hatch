extends Marker2D
var PLAYER = preload("res://Gameplay Elements/Bossfight/Phase 3/phase_3_player.tscn")
var MULTIHIT = preload("res://Gameplay Elements/Bossfight/Phase 3/phase_three_multi_hit.tscn")
var VERTATK = preload("res://Gameplay Elements/Bossfight/Phase 3/vert_attack.tscn")
var HORATK = preload("res://Gameplay Elements/Bossfight/Phase 3/hor_attack.tscn")

var playerinst
var damageDealtTotal = 0
var damageDealtRound
var baseTime = 2.8

#STATE MACHINE FUNCTIONS

func enter():
	playerinst = PLAYER.instantiate()
	add_child(playerinst)
	visible = true
func update():
	pass
func exit():
	get_parent().progress()

#OTHER FUNCTIONS

func goDown():#function called by intermission player on space pressed
	pass

func playerDied():
	#play death anim w/ game paused and then call parent's playerdied func
	get_parent().resetTimer.start()
	get_tree().paused = true
	playerinst.queue_free()

var unusedIntervals
var timeOffset = 0
func _on_attack_timer_timeout():
	if baseTime > 1.0:
		baseTime -= 0.2
	elif baseTime > 0.7:
		timeOffset += 0.1
		baseTime -= 0.1
	unusedIntervals = [-400,-200,0,200,400]
	var baseAtkRange
	
	if baseTime > 2.0:
		baseAtkRange = randi_range(2,3)
	elif baseTime > 1.3:
		baseAtkRange = randi_range(1,2)
	else:
		baseAtkRange = 1
		if randi() % 3 == 0:
			baseAtkRange += 1
		
	var chosenIntervalIdx
	
	for i in range(baseAtkRange):
		var vertAtkInst = VERTATK.instantiate()
		chosenIntervalIdx = randi_range(0,unusedIntervals.size()-1)
		vertAtkInst.position.x = unusedIntervals[chosenIntervalIdx]
		unusedIntervals.pop_at(chosenIntervalIdx)
		add_child(vertAtkInst)
		vertAtkInst.attack(baseTime+timeOffset,false)
	
	unusedIntervals = [-400,-200,0,200,400]
	for i in range(baseAtkRange):
		var horAtkInst = HORATK.instantiate()
		chosenIntervalIdx = randi_range(0,unusedIntervals.size()-1)
		horAtkInst.position.y = unusedIntervals[chosenIntervalIdx]
		unusedIntervals.pop_at(chosenIntervalIdx)
		add_child(horAtkInst)
		horAtkInst.attack(baseTime+timeOffset,true)
	$AttackTimer.wait_time = baseTime
