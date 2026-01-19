extends Node2D
var phases #the instances being used
var PHASES = [null,preload("res://Gameplay Elements/Bossfight/Phase 2/phase_two.tscn"),preload("res://Gameplay Elements/Bossfight/Phase 3/phase_three.tscn")]
var phaseInstances = [] #all instances, must be cleared
var curPhaseIdx = 0
var lives = 3
var resetTimer
func _ready():
	Globals.normalLayer = self
	resetTimer = $ResetTimer
	phases = [$PhaseOne,null,null] #insert when next phase is instantiated
	phases[0].enter() 

func _physics_process(_delta):
	phases[curPhaseIdx].update()
	$mainCamera/LivesCounter.text = "Lives: " + str(lives)

func progress(): #EXIT FUNCTION CALLED BY EACH PHASE
	curPhaseIdx+=1
	var curPhaseInst = PHASES[curPhaseIdx].instantiate()
	phases.insert(curPhaseIdx,curPhaseInst)
	add_child(curPhaseInst)
	phaseInstances.append(curPhaseInst)
	phases[curPhaseIdx].enter()

func _on_reset_timer_timeout(): #called 3 seconds after player death
	phases[curPhaseIdx].visible = false
	for phase in phaseInstances:
		if phase:
			phase.queue_free()
	phaseInstances.clear()
	print("timed out")
	get_tree().paused = false
	lives -= 1
	if lives == 0:
		print("FULLY DEAD")
	curPhaseIdx = 0
	phases[curPhaseIdx].enter()
