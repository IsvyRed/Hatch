extends RigidBody2D
var medinita = preload("res://Gameplay Elements/Enemies/Medina.tscn")

func _on_timer_timeout():
	queue_free()
