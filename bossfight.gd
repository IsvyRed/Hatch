extends Node2D
#Make a state machine that progresses through the phases and updates them from this physics process
var phases
var curPhaseIdx = 0
var lives = 3
func _ready():
	Globals.normalLayer = self
	phases = [$PhaseOne,$PhaseTwo,$PhaseThree]
	phases[0].enter() 

func _physics_process(_delta):
	phases[curPhaseIdx].update()
	$mainCamera/LivesCounter.text = "Lives: " + str(lives)

func progress(): #EXIT FUNCTION CALLED BY EACH PHASE
	curPhaseIdx+=1
	phases[curPhaseIdx].enter()
