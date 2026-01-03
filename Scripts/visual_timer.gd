extends Label
var timer
func _ready():
	Globals.onScreenTimer = self
	timer = Globals.player.get_child(-2)
func _physics_process(_delta):
	text = str(snapped(timer.time_left,0.01))
