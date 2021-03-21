extends Node2D
const Y_CORDINATE=600

export(NodePath)var player_path

var Platforms:Dictionary={1:preload("res://Platforms/startplatform.tscn")}

var Platform_Array:Array=[Platforms[1]]
var  last_platform_componets:Array=[]
var ending_position

onready var first_platform=get_node("startplatform")
onready var player=get_node(player_path)
func _ready():
	ending_position=(first_platform.end_point.global_position)
	for i in range(0,5):
		spawn_platforms()

func _physics_process(delta):
	var distance=ending_position.distance_to(player.global_position)
	if distance <1500:
		spawn_platforms()
func spawn_platforms():
	last_platform_componets=spawn_platform(Vector2(ending_position))
	ending_position=(last_platform_componets[0].end_point.global_position)
func spawn_platform(Position:Vector2)->Array:
	var platform_child=take_random_platform(Platform_Array).instance()
	platform_child.position=Position
	add_child(platform_child)
	return [platform_child,Position]


func take_random_platform(arrays:Array)->PackedScene:
	var chance = (randi()%arrays.size())
	var platform_to_spwan=arrays[chance]
	return platform_to_spwan



