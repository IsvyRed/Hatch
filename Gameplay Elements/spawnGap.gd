extends Area2D
var type = "gap"
func _ready():
	Globals.gaps.append(self)
