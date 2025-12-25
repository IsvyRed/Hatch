extends Area2D
#ADD DYING TIMER -- cut to rooftop is too harsh right now, doesn't allow player to see what they did wrong
var BUS = preload("res://Gameplay Elements/enemy_spawn_bus.tscn")
var VISIONCAST = preload("res://Gameplay Elements/player_vision.tscn")
var DESTRUCTIONCAST = preload("res://Gameplay Elements/destructionCast.tscn")
var DEBRISSPAWNER = preload("res://Gameplay Elements/debris_spawner.tscn")
var AFTERIMAGE = preload("res://Gameplay Elements/after_image.tscn")
var FALLINGPLAYER = preload("res://Gameplay Elements/falling_player.tscn")

var dead = false
var lastRot
var lastDirection
var type = "player"
var readyToMove = true
var enemyHit = false
var lastMovedF = 3 #Frames since last movement, set to threshold+1 to omit first instance of threshold met
var floorQueued = false
var nextFloorF = 0

func _ready():
	Globals.player = self

func _physics_process(_delta):
	#PHYSICS CLOCK BASED SLIDE DELAY -- timer provided inconsistencies
	if lastMovedF == 2:
		_on_slide_timer_timeout()
	if floorQueued and nextFloorF == 10:
		$GameOverTimer.start()
		nextFloor()
	lastMovedF += 1
	nextFloorF += 1
	if not dead:
		if Input.is_action_just_pressed("Left") and readyToMove:
			readyToMove = false
			lastMovedF = 0
			var visionCast = VISIONCAST.instantiate()	
			lastDirection = Vector2(-200,0)
			visionCast.set_target_position(Vector2(-200,0))
			visionCast.connect("validTile",Callable(self,"onValidTile"))
			visionCast.connect("deathTile",Callable(self,"onDeathTile"))
			add_child(visionCast)
			Globals.lastDirection = lastDirection
			#Shapecast for responsive destruction
			var destructionCast = DESTRUCTIONCAST.instantiate()
			destructionCast.set_target_position(lastDirection)
			add_child(destructionCast)
			#afterimage cast
			var afterImage = AFTERIMAGE.instantiate()
			add_sibling(afterImage)
			afterImage.rotation = PI
			lastRot = afterImage.rotation
			afterImage.position = position + lastDirection
			afterImage.play()
			#Camera movement
			Globals.sceneCamera.flinch(lastDirection)
		elif Input.is_action_just_pressed("Right") and readyToMove:
			readyToMove = false
			lastMovedF = 0
			var visionCast = VISIONCAST.instantiate()	
			lastDirection = Vector2(200,0)
			visionCast.set_target_position(Vector2(200,0))
			visionCast.connect("validTile",Callable(self,"onValidTile"))
			visionCast.connect("deathTile",Callable(self,"onDeathTile"))
			add_child(visionCast)
			Globals.lastDirection = lastDirection
			#Shapecast for responsive destruction
			var destructionCast = DESTRUCTIONCAST.instantiate()
			destructionCast.set_target_position(lastDirection)
			add_child(destructionCast)
			#afterimage cast
			var afterImage = AFTERIMAGE.instantiate()
			add_sibling(afterImage)
			lastRot = afterImage.rotation
			afterImage.position = position + lastDirection
			afterImage.play()
			#Camera movement
			Globals.sceneCamera.flinch(lastDirection)
		elif Input.is_action_just_pressed("Up") and readyToMove:
			readyToMove = false
			lastMovedF = 0
			lastDirection = Vector2(0,-200)
			var visionCast = VISIONCAST.instantiate()	
			visionCast.set_target_position(Vector2(0,-200))
			visionCast.connect("validTile",Callable(self,"onValidTile"))
			visionCast.connect("deathTile",Callable(self,"onDeathTile"))
			add_child(visionCast)
			Globals.lastDirection = lastDirection
			#Shapecast for responsive destruction
			var destructionCast = DESTRUCTIONCAST.instantiate()
			destructionCast.set_target_position(lastDirection)
			add_child(destructionCast)
			#afterimage cast
			var afterImage = AFTERIMAGE.instantiate()
			add_sibling(afterImage)
			afterImage.rotation = -PI/2
			lastRot = afterImage.rotation
			afterImage.position = position + lastDirection
			afterImage.play()
			#Camera movement
			Globals.sceneCamera.flinch(lastDirection) 
		elif Input.is_action_just_pressed("Down") and readyToMove:
			readyToMove = false
			lastMovedF = 0
			lastDirection = Vector2(0,200)
			var visionCast = VISIONCAST.instantiate()	
			visionCast.set_target_position(Vector2(0,200))
			visionCast.connect("validTile",Callable(self,"onValidTile"))
			visionCast.connect("deathTile",Callable(self,"onDeathTile"))
			add_child(visionCast)
			Globals.lastDirection = lastDirection
			#Shapecast for responsive destruction
			var destructionCast = DESTRUCTIONCAST.instantiate()
			destructionCast.set_target_position(lastDirection)
			add_child(destructionCast)
			#afterimage cast
			var afterImage = AFTERIMAGE.instantiate()
			add_sibling(afterImage)
			afterImage.rotation = PI/2
			lastRot = afterImage.rotation
			afterImage.position = position + lastDirection
			afterImage.play()
			#Camera movement
			Globals.sceneCamera.flinch(lastDirection)
		if Input.is_action_just_pressed("Attack") or Input.is_action_just_pressed("Attack1") or Input.is_action_just_pressed("Attack2"):
			$AnimationHandler.playAttack()
			if has_overlapping_areas():
				get_overlapping_areas()[0].takeDamage()
			else:
				missedEnemy()
		if Input.is_action_just_pressed("Next Floor"):
			if Globals.enemiesLeft <= 0:
				$AnimationHandler.playDrop()
				get_parent().drop()
				Globals.sceneCamera.flinch(Vector2(0,700))
				floorQueued = true
				nextFloorF = 0
				
			else: #DEATH CONDITION: when attempting to leave a floor that is not clear
				dead = true
				$ResetTimer.start()
				$AnimationHandler.playDeath()
				Globals.deathMessage("Death: Floor was not clear")
				


func onValidTile():
	position += lastDirection
func onDeathTile(): #DEATH CONDITION: when moved out of the map
	dead = true
	$ResetTimer.start()
	Globals.deathMessage("Death: Moved out of bounds")
	var fallingPlayer = FALLINGPLAYER.instantiate()
	fallingPlayer.position = position + lastDirection
	add_sibling(fallingPlayer)
	visible = false
	$SlideTimer.stop()
	readyToMove = true
	
func missedEnemy(): #DEATH CONDITION: when swinging at the air
	dead = true
	$ResetTimer.start()
	$AnimationHandler.playDeath()
	Globals.deathMessage("Death: Missed enemy")
	
func touchedEnemy(): #helps dictate if you should slide past a tile when moving
	enemyHit = true
	#animation handler
	$AnimationHandler.play(lastDirection)
	
func _on_slide_timer_timeout(): #no longer a timer, frames are counted in physics clock. This is the cooldown between movements, and dictates if you should slide across multiple tiles
	if not enemyHit:
		var visionCast = VISIONCAST.instantiate()	
		visionCast.set_target_position(lastDirection)
		visionCast.connect("validTile",Callable(self,"onValidTile"))
		visionCast.connect("deathTile",Callable(self,"onDeathTile"))
		add_child(visionCast)
		$SlideTimer.start()
		#Slide destruction cast
		var destructionCast = DESTRUCTIONCAST.instantiate()
		destructionCast.set_target_position(lastDirection*1.1)
		add_child(destructionCast)
		#Slide afterimage
		var afterImage = AFTERIMAGE.instantiate()
		add_sibling(afterImage)
		afterImage.rotation  = lastRot
		afterImage.position = position + lastDirection
		afterImage.play()
	readyToMove = true
	enemyHit = false
	
func _on_game_over_timer_timeout(): #the 3 seconds you have to clear a floor
	if not dead:
		$ResetTimer.start()
		$AnimationHandler.playDeath()
		Globals.deathMessage("Death: Out of time")
		$GameOverTimer.start()
		print("Dead (Out of time)")
	dead = true
	
func _on_reset_timer_timeout(): #the time between your death and the floor resetting
	Globals.resetRun()
	
func nextFloor():
	var newBus = BUS.instantiate()
	newBus.position = position
	get_parent().add_child(newBus)
	Globals.floor += 1
	Globals.clearEnemies()
	
	
	var destructibleSpawner = DEBRISSPAWNER.instantiate()
	add_child(destructibleSpawner)
	
	print("Floor " + str(Globals.floor) + ": ")
