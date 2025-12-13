extends Label
func _ready():
	text = Globals.deathCon
func prompt():
	$Timer.start()

func _on_timer_timeout():
	visible = false
