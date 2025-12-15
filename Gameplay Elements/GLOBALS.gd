extends Node
#TO DO add lose function with small buffer before reset -- this will become the main game handler

#format: floorThreshold : [upgradeUnits, enemyCount (low end, high end is +2)]
var difficultyHash = {0: [0,1], 5: [1,2], 10: [1,3], 15: [2,3], 20: [2,4], 30: [3,4], 45: [4,5], 55: [3,6]}

@warning_ignore("shadowed_global_identifier")
var floor = 0
var enemiesLeft =  0
var enemies = [] #Use this reference to upgrade enemies when bus is cornered
var upgradeUnits = 0
var usedEnemies = []
var debugDeathMsg = null
var lastDirection
var deathCon = ""
var enemyCountBase = 1

var debrisList = []
var validTiles = []

var levels = ["res://Gameplay Elements/rooftop.tscn","res://Gameplay Elements/main_level.tscn"] #MISSING BOTTOM FLOOR ENDING LEVEL
var curLevel = 0

func clearEnemies():
	enemies.clear()
	enemiesLeft = 0
	for debris in debrisList:
		debris.queue_free()
	debrisList.clear()
	
func runUpgrade():
	if difficultyHash.has(floor):
		print("difficultybump")
		upgradeUnits = difficultyHash[floor][0]
		enemyCountBase = difficultyHash[floor][1]
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
	curLevel = 0
	Globals.clearEnemies()
	if debugDeathMsg != null:
		debugDeathMsg.prompt()
	get_tree().change_scene_to_file(levels[curLevel])
