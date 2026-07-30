extends AnimatedSprite2D
#makre more anims for htis
func _ready():
	animation = str(randi_range(0,1))
	play()
