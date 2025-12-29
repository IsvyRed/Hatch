extends Label

func _ready():
	pass

func _process(_delta):
	text = "Floor: " + str(Globals.floor) + "      Best: " + str(Globals.best)
