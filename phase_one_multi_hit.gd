extends Area2D
var type = "enemy"
var dmgTaken = 0
var HPMARKER = preload("res://Gameplay Elements/Bossfight/Phase 1/damage_dealt_marker.tscn")
var DMGEXPIRE = preload("res://Gameplay Elements/Bossfight/Phase 1/phase_1_dmg_expire.tscn")

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

func _physics_process(_delta):
	$PlayerDir.look_at(Globals.player.position)

func takeDamage():
	dmgTaken += 1
	$Iris.play("dmg")
	get_parent().dmgDealtRound+=1
	$Sprite.animation = str(randi_range(0,2))
	$Sprite.play()
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

func cfree():
	if dmgTaken > 0:
		var inst = DMGEXPIRE.instantiate()
		inst.position = position
		add_sibling(inst)
	queue_free()


func _on_sprite_animation_finished():
	$Iris.animation = "default"
	$Iris.visible = true
	$Iris.play()


func _on_iris_animation_finished():
	$Iris.animation = "default"
	$Iris.visible = true
	$Iris.play()
