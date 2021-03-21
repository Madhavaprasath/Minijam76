extends Area2D
var velocity
export (int) var speed=400
export (int) var lifetime=1.0
export (int) var damage=1.0


func _process(delta):
	position.x+=speed*delta

func destroy():
	queue_free()

func _on_Bullet_body_entered(body):
	destroy()


func _on_Lifetime_timeout():
	destroy()
