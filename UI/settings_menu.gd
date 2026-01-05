extends Control

func _ready():
	$Slider/SliderNum.text = str(PlayerSettings.screenshakeMultiplier)
	$Slider.value = PlayerSettings.screenshakeMultiplier

#SCREENSHAKE
func _on_slider_value_changed(value):
	PlayerSettings.screenshakeMultiplier = value
	$Slider/SliderNum.text = str(value)

#BLOOD
func _on_blood_off_button_down():
	PlayerSettings.bloodSetting = 0
func _on_blood_reg_button_down():
	PlayerSettings.bloodSetting = 1
func _on_blood_max_button_down():
	PlayerSettings.bloodSetting = 2

#STARTING
func _on_beginning_button_down():
	get_parent().startAt(0)
func _on_checkpoint_button_down():
	get_parent().startAt()
func _on_max_diff_button_down():
	get_parent().startAt(150)
func _on_reset_checkpoint_button_down():
	Globals.best = 0
	Globals.unlockedCheckpoint = 0
	Globals.globalSave()
