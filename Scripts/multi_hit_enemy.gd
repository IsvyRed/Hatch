extends Area2D
var type = "enemy"
var hp = 2
var HPMARKER = preload("res://Gameplay Elements/Enemies/test_marker.tscn")
var DEADBODY = preload("res://Gameplay Elements/Enemies/dead_body.tscn")
var SPRAY = preload("res://Gameplay Elements/Blood/spray_particles.tscn")
var DROPLET = preload("res://Gameplay Elements/Blood/droplet.tscn")
var bleeding = true
var bloodSetting
#FORMAT: array in array = setting config. within config array: 0: can bleed, 1: chance of non bleeding enemy (higher is lesser) 2: low end of blood droplets, 3: high end of blood droplets
var bloodSettingTable = [[false,1,0,0],[true,5,7,12],[true,10,15,22]]

func _ready():
	bloodSetting = PlayerSettings.bloodSetting
	var bleedmod = randi()
	if bleedmod % bloodSettingTable[bloodSetting][1] == 0:
		bleeding = false
	if not bloodSettingTable[bloodSetting][0]:
		bleeding = false
	$Sprite.play()
	$Sprite.speed_scale = randf_range(0.8,1.2)
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
	
	var spray = SPRAY.instantiate()
	spray.position = position
	add_sibling(spray)
	spray.emit(Vector2(0,-200))
	$HealthOrbit.get_children()[0].die()
	
	var dropletdir = Vector2(0,-3)
	for i in range(randi_range(bloodSettingTable[bloodSetting][2],bloodSettingTable[bloodSetting][3])):
		var droplet = DROPLET.instantiate()
		randomize()
		dropletdir.y += randf_range(-1,1)
		dropletdir.x += randf_range(-1,1)
		droplet.position = position
		add_sibling(droplet)
		droplet.start(dropletdir)
	
	if hp == 0:
		var deadBody = DEADBODY.instantiate()
		deadBody.bleeding = bleeding
		deadBody.position = position
		add_sibling(deadBody)
		deadBody.destroy(Vector2(0,-200))
		Globals.enemiesLeft -= 1
		queue_free() 

func _on_area_entered(_area):
	#GIVE PLAYER FEEDBACK
	get_overlapping_areas()[0].touchedEnemy()

func upgrade():
	hp += 1
	for child in $HealthOrbit.get_children():
		child.die(false)
	var inc = 1.0/hp
	for i in hp:
		var curMarker = HPMARKER.instantiate()
		$HealthOrbit.add_child(curMarker)
		curMarker.progress_ratio += inc*i
