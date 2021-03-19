extends KinematicBody2D

const speed=250
const jump_speed=-500
const gravity=900

var states={}
var current_state
var velocity=Vector2()


func _physics_process(delta):
	apply_movement(delta)
	var state=match_state(delta)
	if state !=null:
		current_state=state
		print(state)
		animation(state)

func apply_movement(delta):
	pass

func match_state(delta):
	return null

func animation(state):
	pass 
