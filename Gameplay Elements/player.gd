extends Area2D
#ADD DYING TIMER -- cut to rooftop is too harsh right now, doesn't allow player to see what they did wrong
var BUS = preload("res://Gameplay Elements/enemy_spawn_bus.tscn")
var VISIONCAST = preload("res://Gameplay Elements/player_vision.tscn")
var DESTRUCTIONCAST = preload("res://Gameplay Elements/destructionCast.tscn")
var DEBRISSPAWNER = preload("res://Gameplay Elements/debris_spawner.tscn")
var AFTERIMAGE = preload("res://Gameplay Elements/after_image.tscn")
var lastDirection
var type = "player"
var readyToMove = true
var enemyHit = false

func _physics_process(_delta):
	$VisualTimer.text = str(snapped($GameOverTimer.time_left,0.01))
	if Input.is_action_just_pressed("Left") and readyToMove:
		readyToMove = false
		$SlideTimer.start()
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
		add_child(afterImage)
		afterImage.rotation = PI
		afterImage.play()
	if Input.is_action_just_pressed("Right") and readyToMove:
		readyToMove = false
		$SlideTimer.start()
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
		add_child(afterImage)
		afterImage.play()
	if Input.is_action_just_pressed("Up") and readyToMove:
		readyToMove = false
		$SlideTimer.start()
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
		add_child(afterImage)
		afterImage.rotation = -PI/2
		afterImage.play()
	if Input.is_action_just_pressed("Down") and readyToMove:
		readyToMove = false
		$SlideTimer.start()
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
		add_child(afterImage)
		afterImage.rotation = PI/2
		afterImage.play()
	if Input.is_action_just_pressed("Attack") or Input.is_action_just_pressed("Attack1") or Input.is_action_just_pressed("Attack2"):
		if has_overlapping_areas():
			get_overlapping_areas()[0].takeDamage()
		else:
			missedEnemy()
	if Input.is_action_just_pressed("Next Floor"):
		if Globals.enemiesLeft <= 0:
			var newBus = BUS.instantiate()
			newBus.position = position
			get_parent().add_child(newBus)
			Globals.floor += 1
			Globals.clearEnemies()
			$GameOverTimer.start()
			
			var destructibleSpawner = DEBRISSPAWNER.instantiate()
			add_child(destructibleSpawner)
			
			print("Floor " + str(Globals.floor) + ": ")
			
		else:
			Globals.deathMessage()
			$GameOverTimer.start()
			print("Dead (floor not clear)")
			Globals.floor = 0


func onValidTile():
	position += lastDirection
func onDeathTile():
	Globals.deathMessage()
	print("Dead (out of bounds)")
	Globals.floor = 0
	$SlideTimer.stop()
	readyToMove = true
	
func missedEnemy():
	Globals.deathMessage()
	print("Dead (missed enemy)")
	Globals.floor = 0
	
func touchedEnemy():
	enemyHit = true


func _on_slide_timer_timeout():
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
	readyToMove = true
	enemyHit = false
	

func _on_game_over_timer_timeout():
	Globals.floor = 0
	Globals.deathMessage()
	$GameOverTimer.start()
	print("Dead (Out of time)")
