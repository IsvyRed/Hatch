extends Node
@warning_ignore("shadowed_global_identifier")
var floor = 0
var enemiesLeft =  0
var enemies = [] #Use this reference to upgrade enemies when bus is cornered
var upgradeUnits = 2
var usedEnemies = []
var debugDeathMsg
var lastDirection

func clearEnemies():
	enemies.clear()
	enemiesLeft = 0
	
func runUpgrade():
	for i in upgradeUnits:
		var chosenEnemy = randi_range(0,enemies.size()-1)
		enemies[chosenEnemy].upgrade()
		enemies.pop_at(chosenEnemy)
	usedEnemies.clear()

func deathMessage():
	debugDeathMsg.prompt()
