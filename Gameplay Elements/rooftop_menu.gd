extends Node2D
#make this node communicate with intermission player to help select whether to start from floor 0, checkpoint, go to endless, etc.

func startAt(selectedFloor = Globals.unlockedCheckpoint-1):
	Globals.floor = selectedFloor
	Globals.clearEnemies()
	Globals.nextArea()
	Globals.forceDifficulty()
	print("Floor " + str(Globals.floor) + ": ")
	
func tutorial():
	pass
