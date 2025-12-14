extends Area2D
var MULTIHITENEMY = preload("res://Gameplay Elements/Enemies/multi_hit_enemy.tscn")
var type = "enemy"
var singleUpgrade = true

func _ready():
	Globals.enemiesLeft += 1
	Globals.enemies.append(self)

func _on_area_entered(_area):
	#DIE -- GIVE PLAYER FEEDBACK
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
