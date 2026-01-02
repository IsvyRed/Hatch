extends Area2D
var BUS = preload("res://Gameplay Elements/enemy_spawn_bus.tscn")
var VISIONCAST = preload("res://Gameplay Elements/player_vision.tscn")
var DESTRUCTIONCAST = preload("res://Gameplay Elements/destructionCast.tscn")
var AFTERIMAGE = preload("res://Gameplay Elements/after_image.tscn")
var medinita = preload("res://Gameplay Elements/Enemies/Medina.tscn")

var lastRot
var lastDirection
var type = "player"
var enemyHit = false
var funnycounter = 0
var curAfterImage

func _ready():
	Globals.player = self

func _physics_process(_delta):
	if funnycounter >= 1000:
		var medinitainst = medinita.instantiate()
		add_child(medinitainst)
	if Input.is_action_just_pressed("Left"):
		funnycounter += 1
		var visionCast = VISIONCAST.instantiate()	
		lastDirection = Vector2(-200,0)
		visionCast.set_target_position(Vector2(-200,0))
		visionCast.connect("validTile",Callable(self,"onValidTile"))
		visionCast.connect("deathTile",Callable(self,"onDeathTile"))
		add_child(visionCast)
		Globals.lastDirection = lastDirection
		#Shapecast for responsive destruction
		var destructionCast = DESTRUCTIONCAST.instantiate()
		destructionCast.set_target_position(lastDirection*1.1)
		add_child(destructionCast)
		#afterimage cast
		curAfterImage = AFTERIMAGE.instantiate()
		curAfterImage.rotation = PI
		lastRot = curAfterImage.rotation
	elif Input.is_action_just_pressed("Right"):
		funnycounter += 1
		var visionCast = VISIONCAST.instantiate()	
		lastDirection = Vector2(200,0)
		visionCast.set_target_position(Vector2(200,0))
		visionCast.connect("validTile",Callable(self,"onValidTile"))
		visionCast.connect("deathTile",Callable(self,"onDeathTile"))
		add_child(visionCast)
		Globals.lastDirection = lastDirection
		#Shapecast for responsive destruction
		var destructionCast = DESTRUCTIONCAST.instantiate()
		destructionCast.set_target_position(lastDirection*1.1)
		add_child(destructionCast)
		#afterimage cast
		curAfterImage = AFTERIMAGE.instantiate()
		lastRot = curAfterImage.rotation
	elif Input.is_action_just_pressed("Up"):
		funnycounter += 1
		lastDirection = Vector2(0,-200)
		var visionCast = VISIONCAST.instantiate()	
		visionCast.set_target_position(Vector2(0,-200))
		visionCast.connect("validTile",Callable(self,"onValidTile"))
		visionCast.connect("deathTile",Callable(self,"onDeathTile"))
		add_child(visionCast)
		Globals.lastDirection = lastDirection
		#Shapecast for responsive destruction
		var destructionCast = DESTRUCTIONCAST.instantiate()
		destructionCast.set_target_position(lastDirection*1.1)
		add_child(destructionCast)
		#afterimage cast
		curAfterImage = AFTERIMAGE.instantiate()
		curAfterImage.rotation = -PI/2
		lastRot = curAfterImage.rotation
	elif Input.is_action_just_pressed("Down"):
		funnycounter += 1
		lastDirection = Vector2(0,200)
		var visionCast = VISIONCAST.instantiate()	
		visionCast.set_target_position(Vector2(0,200))
		visionCast.connect("validTile",Callable(self,"onValidTile"))
		visionCast.connect("deathTile",Callable(self,"onDeathTile"))
		add_child(visionCast)
		Globals.lastDirection = lastDirection
		#Shapecast for responsive destruction
		var destructionCast = DESTRUCTIONCAST.instantiate()
		destructionCast.set_target_position(lastDirection*1.1)
		add_child(destructionCast)
		#afterimage cast
		curAfterImage = AFTERIMAGE.instantiate()
		curAfterImage.rotation = PI/2
		lastRot = curAfterImage.rotation
	if Input.is_action_just_pressed("Attack") or Input.is_action_just_pressed("Attack1") or Input.is_action_just_pressed("Attack2"):
		$AnimationHandler.playAttack()
		funnycounter += 1
	if Input.is_action_just_pressed("Next Floor"):
		#CHANGE ALL THIS TO COMMUNICATE WITH ROOFTOP SCENE, THIS WILL BE THE "SELECT" BUTTON
		Globals.floor = Globals.unlockedCheckpoint
		Globals.clearEnemies()
		Globals.nextArea()
		print("Floor " + str(Globals.floor) + ": ")

func onValidTile():
	position += lastDirection
	curAfterImage.position = position
	add_sibling(curAfterImage)
	curAfterImage.play()
func onDeathTile():
	pass
