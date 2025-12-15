extends Marker2D
#Have functions for each type of element to be spawned
#elements should append themselves to global debris list and remove themselves if needed, only removed by global script if left alone until floor changes
#functions should be divided in terms of valid spawn positions
#one or more functions must be dedicated to random, predefined clusters of elements (such as desk + chair + bin)
#no need for a bus system, but remember to prevent overlapping elements. Could use collisions, stored areas + math, or an organized spawn order, preferrably the last.
#execute all functions within 1-3 frames, then queue free on self, making sure all elements are stored as siblings and have been properly kept track of in globals list

var GENERICCLUSTERS = [preload("res://Gameplay Elements/Destructibles/empty_destructible.tscn"),preload("res://Gameplay Elements/Destructibles/Clusters/cluster_4.tscn"), preload("res://Gameplay Elements/Destructibles/Clusters/cluster_1.tscn"), preload("res://Gameplay Elements/Destructibles/Clusters/cluster_2.tscn"),preload("res://Gameplay Elements/Destructibles/Clusters/cluster_3.tscn")]

func _ready():
	spawnGenericClusters()

func spawnGenericClusters():
	for validTile in Globals.validTiles:
		var selectedCluster = GENERICCLUSTERS[randi_range(0,GENERICCLUSTERS.size()-1)].instantiate()
		selectedCluster.position = validTile.position
		get_parent().add_sibling(selectedCluster)
