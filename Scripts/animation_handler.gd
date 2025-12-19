extends Marker2D

var DEATHFLASH = preload("res://Gameplay Elements/bloody_screen.tscn")

@onready var curState = $Idle
@onready var states = {Vector2(0,-200): $SwingU, Vector2(0,200): $SwingD, Vector2(-200,0): $SwingH,Vector2(200,0): $SwingH,}
var attackCount = 0
@onready var attacks = [$Attack1,$Attack2,$Attack3]
var lastAttack

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

func playAttack():
	attackCount += 1
	attacks[attackCount%3].visible = true
	attacks[attackCount%3].play()
		

func playDeath():
	var deathFlash = DEATHFLASH.instantiate()
	add_sibling(deathFlash)
	$DeathShot.visible = true
	$DeathShot.play()

func _on_animation_finished():
	curState.flip_h = false
	curState.visible = false
	curState = $Idle
	$Idle.visible = true
	$Idle.play()
