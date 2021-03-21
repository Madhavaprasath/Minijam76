extends Node2D

var shake_priority=0

func move_screen(vector):
	get_parent().get_node("Camera2D").offset=Vector2(rand_range(-vector.x,vector.x),rand_range(-vector.y,vector.y))

func _shake_the_screen(length,power,priority):
	if priority>shake_priority:
		shake_priority=priority
		get_node("Tween").interpolate_method(self,'move_screen',Vector2(power,power),Vector2(0,0),length,Tween.TRANS_SINE,Tween.EASE_IN,0)
		get_node("Tween").start()


func _on_Tween_tween_started(object, key):
	shake_priority=0
