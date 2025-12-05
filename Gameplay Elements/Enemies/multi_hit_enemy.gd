extends Area2D
var type = "enemy"
var hp = 2
var HPMARKER = preload("res://Gameplay Elements/hp_marker.tscn")

func _ready():
	Globals.enemiesLeft += 1
	Globals.enemies.append(self)
	@warning_ignore("integer_division")
	var inc = 100/hp
	for i in hp:
		var curMarker = HPMARKER.instantiate()
		curMarker.global_position = $HPHolder.global_position
		@warning_ignore("integer_division")
		curMarker.global_position.x -= inc/2
		@warning_ignore("integer_division")
		curMarker.global_position.x += i * inc/2
		$HPHolder.add_child(curMarker)

func takeDamage():
	hp -= 1
	if hp == 0:
		Globals.enemiesLeft -= 1
		queue_free() 

func _on_area_entered(_area):
	#GIVE PLAYER FEEDBACK
	get_overlapping_areas()[0].touchedEnemy()

func upgrade():
	hp += 1
	for child in $HPHolder.get_children():
		child.queue_free()
	@warning_ignore("integer_division")
	var inc = 100/hp
	for i in hp:
		var curMarker = HPMARKER.instantiate()
		curMarker.global_position = $HPHolder.global_position
		@warning_ignore("integer_division")
		curMarker.global_position.x -= inc/2
		@warning_ignore("integer_division")
		curMarker.global_position.x += i * inc/2
		$HPHolder.add_child(curMarker)
