extends "res://Actor/Actor.gd"


var max_jump_height=3*64
var min_jump_height=1.25*64
var max_jump_velocity
var min_jump_velocity
var jump_duration=0.75

class jump:
	var jumping=false
	var can_jump=true
	var can_smash=true
class smash:
	var smashing=false
class moving:
	var direction=1

onready var jump_state=jump.new()
onready var smash_state=smash.new()
onready var moving_state=moving.new()
onready var screen_shake=get_parent().get_node("Screen_shake")

func _init():
	states={1:"Moving",
			2:"Jump",
			3:"Smash",
			4:"Fall"}

func _ready():
	current_state=states[1]
	gravity=(2*max_jump_height)/pow(jump_duration,2)
	max_jump_velocity=-sqrt(2*max_jump_height*gravity)
	min_jump_velocity=-sqrt(2*min_jump_height*gravity)
func apply_movement(delta):
	clamp_player_position()
	Move(delta)
	if current_state !="Smash":
		apply_gravity(delta)
	if current_state in ["Jump"]:
		if is_on_floor():
			jump_state.jumping=true
		elif !is_on_floor():
			jump_state.jumping=false
		smash_state.smashing=false
	if current_state in ["Smash"]:
		velocity.y+=gravity*6*delta
	velocity=move_and_slide(velocity,Vector2.UP)


func match_state(delta):
	match current_state:
		"Moving":
			if jump_state.jumping:
				return states[2]
		"Jump":
			if !jump_state.jumping:
				return states[4]
		"Smash":
			if is_on_floor():
				return states[1]
		"Fall":
			if is_on_floor():
				return states[1]
			if smash_state.smashing:
				return states[3]
	return null

func animation(state):
	animation_player.play(state)

func previous_state_things(previous_state):
	match previous_state:
		"Smash":
			screen_shake._shake_the_screen(0.5,rand_range(4,7),1)


func _unhandled_key_input(event):
	if event.is_action_pressed("ui_up") && current_state in ["Moving"]:
		velocity.y=max_jump_velocity
		jump_state.jumping=true
	if event.is_action_released("ui_up") && velocity.y<min_jump_velocity:
		velocity.y=min_jump_velocity
	if event.is_action_pressed("ui_down")&&current_state in ["Fall"]:
		smash_state.smashing=true

func Move(delta):
	moving_state.direction=int(Input.is_action_pressed("ui_right"))-int(Input.is_action_pressed("ui_left"))
	velocity.x=lerp(velocity.x,speed*moving_state.direction,0.4)

func apply_gravity(delta):
	velocity.y+=gravity*delta

func clamp_player_position():
	position.x=clamp(position.x,-475,475)

