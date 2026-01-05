extends Node2D
#Seamlessly incorporate some landing animation after arbitrary amount of time that is initiated as soon as this node is ready.
func _ready():
	Globals.normalLayer.hideHud()
	Globals.sceneCamera.position.y+=50 #Manual flinch of camera downwards that resets itself
func goDown():
	pass
