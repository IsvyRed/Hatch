extends Control

func _ready():
	$Slider/SliderNum.text = str(PlayerSettings.screenshakeMultiplier)
	$Slider.value = PlayerSettings.screenshakeMultiplier


func _on_slider_value_changed(value):
	PlayerSettings.screenshakeMultiplier = value
	$Slider/SliderNum.text = str(value)


func _on_blood_off_button_down():
	PlayerSettings.bloodSetting = 0


func _on_blood_reg_button_down():
	PlayerSettings.bloodSetting = 1


func _on_blood_max_button_down():
	PlayerSettings.bloodSetting = 2
