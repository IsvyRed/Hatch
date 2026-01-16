extends Camera2D

var curTween = 0
var positionOffset = Vector2(0,0) #affected by screenshake, gets reduced each frame to ease back to the target position
var targetPos = Vector2(0,0) #affected by manual controls, will be eased into after screenshake

func _ready():
	print("ready")
	Globals.sceneCamera = self
	
func flinch(direction = Vector2(0,0)):
	positionOffset -= direction/12 * PlayerSettings.screenshakeMultiplier

	
func _physics_process(_delta):
	positionOffset /= 1.1
	position = targetPos + positionOffset
