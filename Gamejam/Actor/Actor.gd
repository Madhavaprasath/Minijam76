extends KinematicBody2D

const speed=400
const jump_speed=-650

var gravity=900
var states={}
var current_state
var previous_state
var velocity=Vector2()
var health=100


onready var animation_player=get_node("body/AnimationPlayer")
func _physics_process(delta):
	apply_movement(delta)
	var state=match_state(delta)
	if state !=null:
		previous_state=current_state
		current_state=state
		print(state)
		animation(state)
		previous_state_things(previous_state)
func apply_movement(delta):
	pass

func match_state(delta):
	return null

func animation(state):
	pass 

func previous_state_things(previous_state):
	pass

func take_damage(damage):
	health-=damage
	if health<=0:
		die()

func die():
	pass
