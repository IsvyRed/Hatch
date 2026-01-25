extends Marker2D
var PLAYER = preload("res://Gameplay Elements/Bossfight/Phase 3/phase_3_player.tscn")
var playerinst
var damageDealtTotal = 0

#STATE MACHINE FUNCTIONS

func enter():
	playerinst = PLAYER.instantiate()
	add_child(playerinst)
	visible = true
func update():
	pass
func exit():
	get_parent().progress()

#OTHER FUNCTIONS

func goDown():#function called by intermission player on space pressed
	pass

func playerDied():
	#play death anim w/ game paused and then call parent's playerdied func
	get_parent().resetTimer.start()
	get_tree().paused = true
	playerinst.queue_free()


func _on_attack_timer_timeout():
	pass # Replace with function body.
