extends "res://Actor/Actor.gd"


func _init():
	states={1:"moving",
			2:"Jump",
			3:"smash"}

func apply_movement(delta):
	velocity.x=speed
	velocity=move_and_slide(velocity,Vector2.UP)

func match_state(delta):
	return null

func animation(transition):
	pass 
