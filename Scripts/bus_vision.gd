extends RayCast2D
#SET MOVEMENT BOXES 200 PX APART

signal Valid
signal Invalid
func _physics_process(_delta):
	if is_colliding():
		var collider = get_collider()
		if collider.type == "valid":
			emit_signal("Valid")
		elif collider.type == "death":
			emit_signal("Invalid")
		elif collider.type == "enemy":
			emit_signal("Invalid")
		elif collider.type == "player":
			emit_signal("Invalid")
		elif collider.type == "gap":
			emit_signal("Invalid")
	queue_free()
