extends Area2D
var MULTIHITENEMY = preload("res://Gameplay Elements/Enemies/multi_hit_enemy.tscn")
var DEADBODY = preload("res://Gameplay Elements/Enemies/dead_body.tscn")
var type = "enemy"
var singleUpgrade = true

func _ready():
	Globals.enemiesLeft += 1
	Globals.enemies.append(self)
	$Sprite.play()
	$Sprite.speed_scale = randf_range(0.8,1.2)

func _on_area_entered(_area):
	#DIE -- GIVE PLAYER FEEDBACK
	var deadBody = DEADBODY.instantiate()
	deadBody.position = position
	add_sibling(deadBody)
	deadBody.destroy(Globals.lastDirection)
	get_overlapping_areas()[0].touchedEnemy()
	Globals.enemiesLeft -= 1
	queue_free()

func upgrade():
	var upgradedEnemy = MULTIHITENEMY.instantiate()
	if singleUpgrade:
		singleUpgrade = false
		upgradedEnemy.position = position
		add_sibling(upgradedEnemy)
		Globals.enemiesLeft -= 1
		queue_free()
	else:
		upgradedEnemy.upgrade()

func takeDamage():
	pass
