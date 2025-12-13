extends Node
#TO DO add lose function with small buffer before reset -- this will become the main game handler
@warning_ignore("shadowed_global_identifier")
var floor = 0
var enemiesLeft =  0
var enemies = [] #Use this reference to upgrade enemies when bus is cornered
var upgradeUnits = 2
var usedEnemies = []
var debugDeathMsg = null
var lastDirection
var deathCon = ""

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
	for i in upgradeUnits:
		var chosenEnemy = randi_range(0,enemies.size()-1)
		enemies[chosenEnemy].upgrade()
		enemies.pop_at(chosenEnemy)
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
