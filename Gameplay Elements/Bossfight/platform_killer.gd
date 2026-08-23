extends Area2D
func _physics_process(_delta):
	position = Globals.sceneCamera.position
func _ready():
	$AnimatedSprite2D.play()
