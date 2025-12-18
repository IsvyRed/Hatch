extends Area2D
var type = "enemy"
var hp = 2
var HPMARKER = preload("res://Gameplay Elements/Enemies/test_marker.tscn")
var DEADBODY = preload("res://Gameplay Elements/Enemies/dead_body.tscn")

func _ready():
	Globals.enemiesLeft += 1
	Globals.enemies.append(self)
	@warning_ignore("integer_division")
	var inc = 1.0/hp
	for i in hp:
		var curMarker = HPMARKER.instantiate()
		$HealthOrbit.add_child(curMarker)
		curMarker.progress_ratio += inc*i

func takeDamage():
	hp -= 1
	if hp == 0:
		var deadBody = DEADBODY.instantiate()
		deadBody.position = position
		add_sibling(deadBody)
		deadBody.destroy(Vector2(0,-200))
		Globals.enemiesLeft -= 1
		queue_free() 
	$HealthOrbit.get_children()[0].die()

func _on_area_entered(_area):
	#GIVE PLAYER FEEDBACK
	get_overlapping_areas()[0].touchedEnemy()

func upgrade():
	hp += 1
	for child in $HealthOrbit.get_children():
		child.queue_free()
	@warning_ignore("integer_division")
	var inc = 1.0/hp
	for i in hp:
		var curMarker = HPMARKER.instantiate()
		$HealthOrbit.add_child(curMarker)
		curMarker.progress_ratio += inc*i
