extends Area2D
#one instance this idiot keeps spawning on the first boss phase stacked on top of the player for some reason, it's causing issues
var MULTIHITENEMY = preload("res://Gameplay Elements/Enemies/multi_hit_enemy.tscn")
var DEADBODY = preload("res://Gameplay Elements/Enemies/dead_body.tscn")
var SPRAY = preload("res://Gameplay Elements/Blood/spray_particles.tscn")
var DROPLET = preload("res://Gameplay Elements/Blood/droplet.tscn")
var type = "enemy"
var singleUpgrade = true
var bleeding = true
var bloodSetting
#FORMAT: array in array = setting config. within config array: 0: can bleed, 1: chance of non bleeding enemy (higher is lesser) 2: low end of blood droplets, 3: high end of blood droplets
var bloodSettingTable = [[false,1,0,0],[true,5,5,10],[true,10,13,20]]

func _ready():
	bloodSetting = PlayerSettings.bloodSetting
	var bleedmod = randi()
	if bleedmod % bloodSettingTable[bloodSetting][1] == 0:
		bleeding = false
	if not bloodSettingTable[bloodSetting][0]:
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
		#see formatting table to understand this nonsense
		for i in range(randi_range(bloodSettingTable[bloodSetting][2],bloodSettingTable[bloodSetting][3])):
			var droplet = DROPLET.instantiate()
			randomize()
			dropletdir.y += randf_range(-1,1)
			dropletdir.x += randf_range(-1,1)
			droplet.position = position
			add_sibling(droplet)
			droplet.start(dropletdir)
	
	Globals.enemiesLeft -= 1
	queue_free()
