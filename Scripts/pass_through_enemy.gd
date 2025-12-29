extends Area2D
var MULTIHITENEMY = preload("res://Gameplay Elements/Enemies/multi_hit_enemy.tscn")
var DEADBODY = preload("res://Gameplay Elements/Enemies/dead_body.tscn")
var SPRAY = preload("res://Gameplay Elements/Blood/spray_particles.tscn")
var DROPLET = preload("res://Gameplay Elements/Blood/droplet.tscn")
var type = "enemy"
var singleUpgrade = true
var bleeding = true

func _ready():
	var bleedmod = randi()
	if bleedmod % 3 == 0:
		bleeding = false
	Globals.enemiesLeft += 1
	Globals.enemies.append(self)
	$Sprite.play()
	$Sprite.speed_scale = randf_range(0.8,1.2)

func _on_area_entered(_area):
	var deadBody = DEADBODY.instantiate()
	deadBody.position = position
	call_deferred("deferredDeath",deadBody)

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

func deferredDeath(deadBody):
	add_sibling(deadBody)
	deadBody.destroy(Globals.lastDirection)
	deadBody.bleeding = bleeding
	get_overlapping_areas()[0].touchedEnemy()
	
	var spray = SPRAY.instantiate()
	spray.position = position
	add_sibling(spray)
	spray.emit(Globals.lastDirection)
	 
	if bleeding:
		var dropletdir = Globals.lastDirection/50 
		for i in range(randi_range(3,7)):
			var droplet = DROPLET.instantiate()
			randomize()
			dropletdir.y += randf_range(-1,1)
			dropletdir.x += randf_range(-1,1)
			droplet.position = position
			add_sibling(droplet)
			droplet.start(dropletdir)
	
	Globals.enemiesLeft -= 1
	queue_free()
