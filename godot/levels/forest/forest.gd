extends Node2D

const GROUND = preload("res://levels/forest/ground.png")
const SKY = preload("res://levels/forest/sky.png")
const FOREGROUND = preload("res://levels/forest/foreground.png")
const BACKGROUND = preload("res://levels/forest/background.png")

const TREE = preload("res://levels/forest/objects/Tree.tscn")
const SCARECROW = preload("res://levels/forest/objects/Scarecrow.tscn")

#environment
var container_ground
var container_sky
var container_background
var container_foreground

#obstacles
var trees
var scarecrows

var viewport_width

var girl

func _ready():
	girl = get_node("Girl")
	#print(get_viewport().get_visible_rect())
	#print(BACKGROUND.get_size())
	viewport_width = get_viewport_rect().size.x
	var ground_width = GROUND.get_width()
	
	#print(viewport_width)
	#print(background_width)
	
	var min_range = ceil(viewport_width/2/ground_width)
	var max_range = min_range*10
	print("[forest.tscn]: range(%s,%s)" % [-min_range, max_range])
	
	# how far to keep spawning obstacles
	var max_dist = max_range*SKY.get_width()
	#print(max_dist)
	
	container_sky = _add_parallax(1, 1, SKY, 0)
	container_background = _add_parallax(min_range, max_range, BACKGROUND, 50)

	trees = _add_obstacles(0, max_dist, TREE, 100)
	scarecrows = _add_obstacles(0, max_dist, SCARECROW, 100)
	
	container_ground = _add_parallax(min_range, max_range, GROUND, 150)
	container_foreground = _add_parallax(min_range, max_range*2, FOREGROUND, 200)
	
	set_process(true)
	
func _process(delta):
	var girl_speed = girl.get_girl_speed()
	print(girl_speed)
	var delta_girl_speed = delta*girl_speed/500
	container_foreground.translate(Vector2(-delta_girl_speed*600,0))
	#container_ground.translate(Vector2(delta*0))
	container_background.translate(Vector2(delta_girl_speed*400,0))
	container_sky.translate(Vector2(delta_girl_speed*490,0))
	girl.translate(Vector2(delta_girl_speed*500, 0))
	_update_obstacles(trees)
	_update_obstacles(scarecrows)
	#print(girl.get_pos().x)
	#print(delta)

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

func _add_parallax(var widths_left, var widths_right, var texture, var z_index):
	var parallax_base = Node2D.new()
	for x in range(-widths_left, widths_right):
		var tile = Sprite.new()
		tile.set_texture(texture)
		tile.set_pos(Vector2(x*texture.get_width(),0))
		parallax_base.add_child(tile)
	parallax_base.set_z(z_index)
	add_child(parallax_base)
	return parallax_base