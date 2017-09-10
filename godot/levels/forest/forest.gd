extends Node2D

const TREE = preload("res://levels/forest/objects/Tree.tscn")
const SCARECROW = preload("res://levels/forest/objects/Scarecrow.tscn")

#environment
var parallax_containers

#obstacles
var trees
var scarecrows

var viewport_width

var girl

var world_health = 100
onready var fire_shader = get_node("Girl/Shaders")

func _ready():
	girl = get_node("Girl")
	parallax_containers = get_tree().get_nodes_in_group("ParallaxContainer")

	viewport_width = get_viewport_rect().size.x
	var ground_width = 1920
	
	
	var min_range = ceil(viewport_width/2/ground_width)
	var max_range = min_range*10
	print("[forest.tscn]: range(%s,%s)" % [-min_range, max_range])
	
	# how far to keep spawning obstacles
	var max_dist = max_range*1920
	#print(max_dist)

	girl.set_z(499)
	
	trees = _add_obstacles(0, max_dist, TREE, 499)
	scarecrows = _add_obstacles(0, max_dist, SCARECROW, 499)
	
	set_process(true)
	
func _process(delta):
	var girl_speed = girl.get_girl_speed()
	var delta_girl_speed = delta*girl_speed/500
	girl.translate(Vector2(delta_girl_speed*500, 0))
	_update_obstacles(trees)
	_update_obstacles(scarecrows)
	#print(girl.get_pos().x)

	for container in parallax_containers:
		container.parallax_translate(delta_girl_speed)
	
	world_health = max(0, world_health - delta)
	_update_world_health()
		
func _update_world_health():
	print(world_health)
	fire_shader.set_shader_opacity((100 - world_health)/100)

func _update_obstacles(var obstacles):
	#print(obstacles[0])
	var current_position = girl.get_pos().x
	
	for obstacle in obstacles:
		#print(obstacle.get_pos())
		obstacle.update(current_position)
		if (obstacle.get_pos().x > current_position+viewport_width):
			break
	
	while (obstacles[0].get_pos().x < current_position-viewport_width):
		obstacles.pop_front()

func _add_obstacles(var start, var end, var obstacle_preload, var z_index):
	var obstacles = []
	var last_obstacle = start
	while (last_obstacle < end):
		last_obstacle = last_obstacle + randi()%1000+100
		#print(last_obstacle)
		var obstacle = obstacle_preload.instance()
		obstacle.set_pos(Vector2(last_obstacle, 0))
		obstacle.set_z(z_index)
		add_child(obstacle)
		obstacles.append(obstacle)
	return obstacles