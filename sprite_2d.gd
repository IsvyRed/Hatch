extends Sprite2D
var frameInterval = 3
var curFrame = 0
func _ready():
	$Lifespan.start()
func _physics_process(_delta):
	curFrame += 1
	if curFrame % frameInterval == 0:
		modulate.a -= 0.3
	

func _on_lifespan_timeout():
	queue_free()
