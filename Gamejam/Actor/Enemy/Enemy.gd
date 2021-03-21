extends "res://Actor/Actor.gd"

signal shoottarget(boolean,direction)
var direction=1
var player=null
onready var maintimer=get_node("Maintimer")
onready var raycast=get_node("body/raycasts/RayCast2D")
onready var gun=get_node("body/Gun")
func _init():
	states={1:"Idle",
			2:"Wander",
			3:"Shoot"}

func _ready():
	current_state=states[1]
func apply_movement(delta):
	if player!=null:
			current_state=states[3]
	if current_state !="Wander":
		velocity.x=lerp(velocity.x,0,0.4)
	if current_state in ["Wander"]:
		if is_on_wall():
			direction*=-1
		elif !raycast.is_colliding() && is_on_floor():
			direction*=-1
		velocity.x=lerp(velocity.x,direction*(speed/2),0.4)
	if current_state in ["Shoot"]:
		if player!=null:
			var diffrence = player.global_position-global_position
			print(diffrence)
			if diffrence.x<0:
				direction=-1
			else:
				direction=1
			gun.shoot(direction)
		else: 
			direction=1
			current_state=choose_array([states[1],states[2]])
	get_node("body").scale.x=direction
	velocity=move_and_slide(velocity,Vector2.UP)



func animation(state):
	pass 

func previous_state_things(previous_state):
	pass


func die():
	pass



func choose_array(array:Array):
	randomize()
	array.shuffle()
	return array.front()



func _on_Maintimer_timeout():
	if current_state !="Shoot":
		current_state=choose_array([states[1],states[2]])
		direction=choose_array([1,-1])
		maintimer.wait_time=choose_array([1.0,1.5,2.0])




func _on_Detect_area_body_entered(body):
	player=body


func _on_Detect_area_body_exited(body):
	player=null
