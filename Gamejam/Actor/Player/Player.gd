extends "res://Actor/Actor.gd"


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
func _init():
	states={1:"Moving",
			2:"Jump",
			3:"Smash",
			4:"Fall"}

func _ready():
	current_state=states[1]

func apply_movement(delta):
	clamp_player_position()
	Move(delta)
	apply_gravity(delta)
	if current_state in ["Jump"]:
		if is_on_floor():
			jump()
		elif !is_on_floor():
			jump_state.jumping=false
	velocity=move_and_slide(velocity,Vector2.UP)
func match_state(delta):
	match current_state:
		"Moving":
			if jump_state.jumping:
				return states[2]
		"Jump":
			if smash_state.smashing:
				return states[3]
			if !jump_state.jumping:
				return states[4]
		"Smash":
			if is_on_floor():
				return states[1]
		"Fall":
			if is_on_floor():
				return states[1]
	return null

func animation(transition):
	pass 

func _unhandled_key_input(event):
	if event.is_action_pressed("ui_up") && current_state in ["Moving"]:
		jump_state.jumping=true

func Move(delta):
	moving_state.direction=int(Input.is_action_pressed("ui_right"))-int(Input.is_action_pressed("ui_left"))
	velocity.x=lerp(velocity.x,speed*moving_state.direction,0.4)
func jump():
	velocity.y=jump_speed
func apply_gravity(delta):
	velocity.y+=gravity*delta
func clamp_player_position():
	position.x=clamp(position.x,0,1020)

