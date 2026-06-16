extends PathFollow2D
func _ready():
	$Sprite2D.animation = str(randi_range(0,2))
	$Sprite2D.play()
func _physics_process(_delta):
	progress_ratio += 0.005
func die(temp):
	queue_free()
