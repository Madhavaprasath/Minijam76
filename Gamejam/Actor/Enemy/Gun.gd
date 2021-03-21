extends Node2D
export(PackedScene) var bullet
export var reload_timer=0.0
var can_shoot=true
onready var bullet_node=get_parent().get_parent().get_parent().get_node("Bullets")


func shoot(direction):
	if can_shoot:
		var bullet_child = bullet.instance()
		bullet_child.position=get_node("Position2D").position
		add_child(bullet_child)
		can_shoot=false
		get_node("Timer").start(reload_timer)


func _on_Timer_timeout():
	can_shoot=true
