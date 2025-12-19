extends RayCast2D
#SET MOVEMENT BOXES 200 PX APART

signal undefined
signal validTile
signal deathTile
func _physics_process(_delta):
	if is_colliding():
		var collider = get_collider()
		if collider.type == "valid":
			emit_signal("validTile")
		elif collider.type == "death":
			emit_signal("deathTile")
		else:
			emit_signal("undefined")
	queue_free()
