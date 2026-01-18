extends Marker2D
var laneHeights = [-200,0,200]
var dmgDealtRound = 0
var ENEMY = preload("res://Gameplay Elements/Bossfight/Phase 1/phase_one_pass_through.tscn")
var MULTIHIT = preload("res://Gameplay Elements/Bossfight/Phase 1/phase_one_multi_hit.tscn")
#this will be called when the boss reaches this platform, spawn a new platform via the phase 2 script when this happens 
func _on_kill_box_area_entered(_area):
	get_parent().damageTaken += dmgDealtRound
	get_parent().spawnPlatform()
	queue_free()
	pass

func spawnEnemy(lane):
	print(get_parent().skipEnemyChance )
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
			var regenemyinst = ENEMY.instantiate()
			regenemyinst.position.y = laneHeights[lane]
			add_child(regenemyinst)
			get_parent().curlane = lane
	else:
		get_parent().skipEnemyChance -= 1
