extends Sprite2D
var splatters = [preload("res://Sprites/Blood/SplatA.png"),preload("res://Sprites/Blood/SplatB.png"),preload("res://Sprites/Blood/SplatC.png"),preload("res://Sprites/Blood/SplatD.png"),preload("res://Sprites/Blood/SplatE.png"),preload("res://Sprites/Blood/SplatF.png")]

func _ready():
	Globals.debrisList.append(self)
	set_texture(splatters[randi_range(0,5)])
