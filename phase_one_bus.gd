extends Marker2D
var VISIONCAST = preload("res://Gameplay Elements/bus_vision.tscn")
var TESTENEMY = preload("res://Gameplay Elements/Bossfight/Phase 1/phase_one_pass_through.tscn")

var frame = 0
#see globals script for hash format
var enemyCount = 8
var enemyTypes = []
var spawnedEnemies = []
#UP DOWN LEFT RIGHT
var allDirections = [Vector2(0,-200),Vector2(0,200),Vector2(-200,0),Vector2(200,0)]
var directionValidity = [false,false,false,false]
var curDirIdx = 0
var randomIdx

var lastSpawned

func _physics_process(_delta):
	frame += 1
	#cast 4 vision cast in all directions -- EVENTUALLY add possibility of enemies being spaced by a tile
	for direction in allDirections:
		var visionCast = VISIONCAST.instantiate()
		visionCast.set_target_position(direction)
		visionCast.connect("Valid",Callable(self,"loopValidTile"))
		visionCast.connect("Invalid",Callable(self,"loopDeathTile"))
		add_child(visionCast)
	curDirIdx = 0
	#choose a valid direction and go there -- could add spacing possibility here instead
	var choosingDir = true
	var failsafemax = 4
	var successfulMove = false
	while choosingDir:
		failsafemax -= 1
		randomIdx = randi_range(0,3)
		if directionValidity[randomIdx]:
			choosingDir = false
			position += allDirections[randomIdx]
			#INSERT GAP CHANCE CODE HERE?
			successfulMove = true
			enemyCount -= 1 #only reduce enemy count when successfully moved
		if failsafemax <= 0:
			choosingDir = false
	#instantiate enemy on own position DO NOT ADD TO TREE, add to spawned enemies array
	if successfulMove:
		var spawnedEnemy = TESTENEMY.instantiate()
		lastSpawned = spawnedEnemy
		spawnedEnemy.global_position = global_position
		spawnedEnemies.append(spawnedEnemy)
		get_parent().add_child(spawnedEnemy)
	var badDirections = 0
	for direction in directionValidity:
		if direction == false:
			badDirections+=1
	if badDirections == 4 and frame > 4:
		print("CORNERED, EXITING")
		#SPAWN "MASH" ENEMY!!!
		lastSpawned.upgrade()
		queue_free()
	#when spawned enough enemies, call function that spawns all enemies on the spawned enemies array
	if enemyCount <= 0:
		#SPAWN "MASH ENEMY!!!
		lastSpawned.upgrade()
		queue_free()

func spawnEnemies():
	pass

func loopValidTile():
	directionValidity[curDirIdx] = true
	curDirIdx+=1
func loopDeathTile():
	directionValidity[curDirIdx] = false
	curDirIdx+=1
