extends CanvasLayer
func _ready():
	Globals.normalLayer = self

func hideHud():
	#Replace references with official hud elements
	$FloorCounter.visible = false
	$Label.visible = false
	$VisualTimer.visible = false
