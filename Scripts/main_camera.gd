extends Camera2D

var curTween = 0

func _ready():
	print("ready")
	Globals.sceneCamera = self
	
func flinch(direction = Vector2(0,0)):
	position -= direction/12 * PlayerSettings.screenshakeMultiplier# change this to variable that can be turned down for accessibility

	
func _physics_process(_delta):
	position /= 1.1
