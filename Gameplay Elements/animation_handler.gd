extends Marker2D

@onready var curState = $Idle
@onready var states = {Vector2(0,-200): $Idle, Vector2(0,200): $Idle, Vector2(-200,0): $SwingH,Vector2(200,0): $SwingH,}

func _ready():
	$Idle.play()

func play(direction):
	curState.flip_h = false
	curState.visible = false
	curState = states[direction]
	curState.visible = true
	curState.play()
	if direction == Vector2(-200,0):
		curState.flip_h = true


func _on_animation_finished():
	curState.flip_h = false
	curState.visible = false
	$Idle.visible = true
	$Idle.play()
