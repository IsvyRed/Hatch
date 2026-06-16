extends Marker2D
var laneHeights = [-200,0,200]
var multihitChildren = []
var dmgDealtRound = 0
var ENEMY = preload("res://Gameplay Elements/Bossfight/Phase 1/phase_one_pass_through.tscn")
var MULTIHIT = preload("res://Gameplay Elements/Bossfight/Phase 1/phase_one_multi_hit.tscn")
var bossfightCamera
var platformVisibility = [true,true,true]

func _ready():
	bossfightCamera = get_parent().get_parent().camera
#this will be called when the boss reaches this platform, spawn a new platform via the phase 2 script when this happens 
func _on_kill_box_area_entered(_area):
	get_parent().damageTaken += dmgDealtRound
	dmgDealtRound = 0
	for child in multihitChildren:
		if child:
			child.queue_free()
	multihitChildren.clear()
	for child in $SpriteHandler.get_children(): #reset platform sprite 
		child.frame = 0
	get_parent().spawnPlatform(self) #changed to move platforms forward instead
	$SpriteHandler.load_visibility(platformVisibility[0],platformVisibility[1],platformVisibility[2])

func addMultihit(multihit):
	multihitChildren.append(multihit)

func spawnEnemy(lane):
	platformVisibility = [false,false,false] #i disagree with your statement (used for platform visibility function call in sprite handler code)
	platformVisibility[lane] = true
	if randi() % get_parent().skipEnemyChance == 0: #chance to skip enemies entirely, chance is reduced for every consecutive skip
		var enemyTypeJudge = randi()
		if enemyTypeJudge % 5 == 0:
			var multihitinst = MULTIHIT.instantiate()
			multihitinst.position.y = laneHeights[lane]
			add_child(multihitinst)
		else:
			var regenemyinst = ENEMY.instantiate()
			regenemyinst.position.y = laneHeights[lane]
			add_child(regenemyinst)
		get_parent().skipEnemyChance = 2
		if randi() % 2 == 0: #switch lane trigger
			var newLane = randi_range(0,2)
			while newLane == lane:
				newLane = randi_range(0,2)
			lane = newLane
			platformVisibility[newLane] = true
			var regenemyinst = ENEMY.instantiate()
			regenemyinst.position.y = laneHeights[lane]
			add_child(regenemyinst)
			get_parent().curlane = lane
		$SpriteHandler.load_visibility(platformVisibility[0],platformVisibility[1],platformVisibility[2])
	else:
		get_parent().skipEnemyChance -= 1

func _on_frame_switcher_timeout():
	for child in $SpriteHandler.get_children():
		child.frame += 1
		z_index = 0 - (abs(6 - $SpriteHandler.get_children()[1].frame)) #for ordering

func set_frame(framein):
	for child in $SpriteHandler.get_children():
		child.frame = framein
		
func load_visibility(top,mid,bot):
	$SpriteHandler.load_visibility(top,mid,bot)
