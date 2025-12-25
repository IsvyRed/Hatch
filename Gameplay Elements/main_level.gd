extends Node2D
func drop():
	$DropAnim.visible = true
	$DropAnim.play()

func _on_drop_anim_animation_finished():
	$DropAnim.visible = false
