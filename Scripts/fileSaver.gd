class_name fileSaver extends Resource

@export var best:int = 0

const SAVEPATH = "res://savefile.tres"

func saveAll():
	print("saved")
	ResourceSaver.save(self, SAVEPATH)
	
func loadAll():
	if ResourceLoader.exists(SAVEPATH):
		return load(SAVEPATH)
	return null
