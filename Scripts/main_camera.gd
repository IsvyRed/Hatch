extends Camera2D

var curTween = 0
var positionOffset = Vector2(0,0) #affected by screenshake, gets reduced each frame to ease back to the target position
var targetPos = Vector2(0,0) #affected by manual controls, will be eased into after screenshake
var tweening = false #pauses recentering while tweening

func _ready():
	print("ready")
	Globals.sceneCamera = self
	
func flinch(direction = Vector2(0,0)):
	positionOffset -= direction/12 * PlayerSettings.screenshakeMultiplier

func moveBy(coord,time):
	var posTween = create_tween()
	posTween.tween_property(self,"position",position+coord,time).set_trans(Tween.TRANS_EXPO).set_ease(Tween.EASE_OUT)
	tweening = true
	posTween.finished.connect(endTween)
	targetPos = targetPos + coord

func endTween():
	print("end tween")
	tweening = false
	
func _physics_process(_delta):
	if not tweening:
		positionOffset /= 1.1
		position = targetPos + positionOffset
