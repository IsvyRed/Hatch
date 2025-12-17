extends Node
#TO DO add lose function with small buffer before reset -- this will become the main game handler

#format: floorThreshold : [upgradeUnits, enemyCount (low end, high end is +2)]
var difficultyHash = {1: [0,1], 5: [1,2], 10: [1,3], 15: [2,3], 20: [2,4], 30: [3,4], 45: [4,5], 55: [3,6]}

@warning_ignore("shadowed_global_identifier")
var floor = 0
var player
var best = 0 #High score basically
var enemiesLeft =  0
var enemies = [] #Use this reference to upgrade enemies when bus is cornered
var upgradeUnits = 0 #overwritten by hash, this is a failsafe
var usedEnemies = []
var debugDeathMsg = null
var lastDirection
var deathCon = ""
var enemyCountBase = 1 #overwritten by hash, this is a failsafe

var debrisList = []
var validTiles = []

var levels = ["res://Gameplay Elements/rooftop.tscn","res://Gameplay Elements/main_level_container.tscn"] #MISSING BOTTOM FLOOR ENDING LEVEL
var curLevel = 0

func clearEnemies():
	enemies.clear()
	enemiesLeft = 0
	for debris in debrisList:
		debris.queue_free()
	debrisList.clear()
	
func updateDifficulty():
	if difficultyHash.has(floor):
		upgradeUnits = difficultyHash[floor][0]
		enemyCountBase = difficultyHash[floor][1]
func runUpgrade():
	for i in upgradeUnits:
		var chosenEnemy = randi_range(0,enemies.size()-1)
		enemies[chosenEnemy].upgrade()
	usedEnemies.clear()

func deathMessage(cause = ""):
	deathCon = cause

func nextArea():
	curLevel += 1
	validTiles.clear()
	get_tree().change_scene_to_file(levels[curLevel])

func resetRun():
	if floor > best:
		best = floor
	curLevel = 0
	floor = 0
	Globals.clearEnemies()
	if debugDeathMsg != null:
		debugDeathMsg.prompt()
	get_tree().change_scene_to_file(levels[curLevel])
