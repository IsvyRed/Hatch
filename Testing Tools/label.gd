extends Label
func _ready():
	Globals.debugDeathMsg = self
func prompt():
	visible = true
	text = "DEAD -- FLOOR RESET"
	Globals.clearEnemies()
	$Timer.start()

func _on_timer_timeout():
	visible = false
