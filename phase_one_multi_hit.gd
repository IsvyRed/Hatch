extends Area2D
var type = "enemy"
var dmgTaken = 0
var HPMARKER = preload("res://Gameplay Elements/Bossfight/Phase 1/damage_dealt_marker.tscn")




#FORMAT: array in array = setting config. within config array: 0: can bleed, 1: chance of non bleeding enemy (higher is lesser) 2: low end of blood droplets, 3: high end of blood droplets
var bloodSettingTable = [[false,1,0,0],[true,5,7,12],[true,10,15,22]]

func _ready():
	$Sprite.play()
	$Sprite.speed_scale = randf_range(0.8,1.2)
	Globals.enemiesLeft += 1
	Globals.enemies.append(self)
	var inc = 1.0/dmgTaken
	for i in dmgTaken:
		var curMarker = HPMARKER.instantiate()
		$HealthOrbit.add_child(curMarker)
		curMarker.progress_ratio += inc*i
	#PHASE 2 STUFF
	if get_parent().has_method("addMultihit"):
		get_parent().addMultihit(self)

func takeDamage():
	dmgTaken += 1
	get_parent().dmgDealtRound+=1
	upgrade() #not actually an upgrade, just adds dmg markers

func _on_area_entered(_area):
	get_overlapping_areas()[0].touchedEnemy()

func upgrade():
	for child in $HealthOrbit.get_children():
		child.die(false)
	var inc = 1.0/dmgTaken
	for i in dmgTaken:
		var curMarker = HPMARKER.instantiate()
		$HealthOrbit.add_child(curMarker)
		curMarker.progress_ratio += inc*i
