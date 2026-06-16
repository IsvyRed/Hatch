extends Area2D
#CHANGE THESE RESOURCES TO BOSS-SPECIFIC ONES
var DEADBODY = preload("res://Gameplay Elements/Bossfight/Phase 1/finger_break.tscn")
var CHAINENDENEMY = preload("res://Gameplay Elements/Bossfight/Phase 1/phase_one_multi_hit.tscn")
var type = "enemy"
var animkey = ["Spawn_A","Spawn_B","Spawn_C"]

func _ready():
	Globals.enemiesLeft += 1
	Globals.enemies.append(self)
	var spawnAnimIdx = randi_range(0,2)
	$Sprite.set_animation(animkey[spawnAnimIdx])
	$Sprite.speed_scale = randf_range(0.8,1.2)
	$Sprite.play()

func _on_area_entered(_area):
	var deadBody = DEADBODY.instantiate()
	deadBody.position = position
	call_deferred("deferredDeath",deadBody)

func takeDamage():
	pass

func upgrade():
	var upgradedEnemy = CHAINENDENEMY.instantiate()
	upgradedEnemy.position = position
	add_sibling(upgradedEnemy)
	Globals.enemiesLeft -= 1
	queue_free()

func deferredDeath(deadBody):
	add_sibling(deadBody)
	get_overlapping_areas()[0].touchedEnemy()
	
	Globals.enemiesLeft -= 1
	queue_free()
