extends Node2D

 
signal entered

var spawn_next_platform=false
var entered=false
var player=null
onready var area_collisionshape=get_node("areas/Area2D/CollisionShape2D")
onready var end_point=get_node("End_point")

func _ready():
	self.connect("entered",self,"trigger_physic_process")
	set_physics_process(false)

func _physics_process(delta):
	var distance = (player.global_position).distance_to(self.global_position)
	if distance>2000:
		queue_free()




func _on_Area2D_body_entered(body):
	player=body
	if player!=null:
		emit_signal("entered")
		spawn_next_platform=true

func trigger_physic_process():
	set_physics_process(true)


