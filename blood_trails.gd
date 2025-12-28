extends Sprite2D
var textures = [preload("res://Sprites/Blood/Trail1.png"),preload("res://Sprites/Blood/Trail2.png"),preload("res://Sprites/Blood/Trail3.png")]

func _ready():
	texture = textures[randi_range(0,2)]
	Globals.debrisList.append(self)
