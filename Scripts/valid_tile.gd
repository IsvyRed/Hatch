extends Area2D
var type = "valid"
func _ready():
	Globals.validTiles.append(self)
