extends Area2D
#parent calls attack function with desired warning time for player, then the timer signals enable collision that search for player and subsequently delete this node
var ATTACKANIM = preload("res://Gameplay Elements/Bossfight/Phase 3/vert_attack_anim.tscn")

var flashTimings = [0,0,0] #frame number in which attack warning will play
var frame = 0

func _ready():
	attack(1)

func attack(warningTime):
	$WarningTimer.wait_time = warningTime
	$LifespanOffset.wait_time = warningTime+0.05
	$WarningTimer.start()
	$LifespanOffset.start()
	var warningTimeFrames = warningTime * 120
	flashTimings[0] = warningTimeFrames / 5 * 2
	flashTimings[1] = warningTimeFrames / 5 * 3
	flashTimings[2] = warningTimeFrames / 5 * 4

func _physics_process(_delta):
	for timing in flashTimings:
		if frame == timing:
			$WarningSprite.visible = true
			$WarningSprite.stop()
			$WarningSprite.play()
	frame += 1

func _on_warning_timer_timeout():
	print("bossattack")
	var animInst = ATTACKANIM.instantiate()
	add_sibling(animInst)
	set_collision_mask_value(3,true)

func _on_lifespan_offset_timeout():
	queue_free()

func _on_area_entered(area):
	area.die()


func _on_warning_sprite_animation_finished():
	$WarningSprite.visible = false
