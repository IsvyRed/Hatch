extends Area2D
var broken = false

func _ready():
	Globals.resetGlass.connect(reset)

func _on_body_entered(_area):
	if not broken:
		$AnimatedSprite2D.play()
		broken = true

func reset():
	$AnimatedSprite2D.frame = 0
	$AnimatedSprite2D.stop()
	broken = false
