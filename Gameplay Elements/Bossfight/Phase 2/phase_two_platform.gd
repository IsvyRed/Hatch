extends Marker2D

#this will be called when the boss reaches this platform, spawn a new platform via the phase 2 script when this happens 
func _on_kill_box_area_entered(_area):
	get_parent().spawnPlatform()
	queue_free()
	pass
