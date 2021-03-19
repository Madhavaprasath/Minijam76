extends KinematicBody2D

var speed=250
var jump_speed=-500
var states={}
var current_state
var velocity=Vector2()

func _physics_process(delta):
	apply_movement(delta)
	var transition=match_state(delta)
	if transition !=null:
		animation(transition)

func apply_movement(delta):
	pass

func match_state(delta):
	return null

func animation(transition):
	pass 
