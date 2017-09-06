extends Node2D

const GROUND = preload("res://levels/forest/ground.png")
const SKY = preload("res://levels/forest/sky.png")
const FOREGROUND = preload("res://levels/forest/foreground.png")
const BACKGROUND = preload("res://levels/forest/background.png")

const TREE = preload("res://levels/forest/objects/Tree.tscn")

#environment
var tiles
var tiles_sky
var base_background
var base_foreground

#obstacles
var trees

#misc
var girl

var viewport_width

func _ready():
	girl = get_node("Girl")
	var camera = get_node("Girl/Camera2D").get_viewport_rect()
	#print(camera)
	#print(get_viewport().get_visible_rect())
	#print(BACKGROUND.get_size())
	viewport_width = get_viewport_rect().size.x
	var ground_width = GROUND.get_width()
	
	tiles = []
	tiles_sky = []
	
	#print(viewport_width)
	#print(background_width)
	
	var min_range = ceil(viewport_width/2/ground_width)
	var max_range = min_range*10
	print("[forest.tscn]: range(%s,%s)" % [-min_range, max_range])
	
	var max_dist = max_range*SKY.get_width()
	#print(max_dist)
	
	for x in range(-min_range, max_range):
		var sky = Sprite.new()
		sky.set_texture(SKY)
		sky.set_pos(Vector2(x*SKY.get_width(),0))
		add_child(sky)
		tiles_sky.append(sky)

	base_background = Node2D.new()
	for x in range(-min_range, max_range):
		var tile = Sprite.new()
		tile.set_texture(BACKGROUND)
		tile.set_pos(Vector2(x*BACKGROUND.get_width(),0))
		base_background.add_child(tile)
	add_child(base_background)

	trees = _add_obstacles(0, max_dist, TREE)

	# floor layer over everything else
	for x in range(-min_range, max_range):
		var tile = Sprite.new()
		tile.set_texture(GROUND)
		tile.set_pos(Vector2(x*GROUND.get_width(),0))
		add_child(tile)
		tiles.append(tile)
	
	girl.set_z(100)
	

	base_foreground = Node2D.new()
	for x in range(-min_range, max_range*2):
		var tile = Sprite.new()
		tile.set_texture(FOREGROUND)
		tile.set_pos(Vector2(x*FOREGROUND.get_width(),0))
		base_foreground.add_child(tile)
	add_child(base_foreground)
	base_foreground.set_z(200)
	
	set_process(true)

func _process(delta):
	base_background.translate(Vector2(delta*100,0))
	girl.translate(Vector2(delta*500, 0))
	base_foreground.translate(Vector2(-delta*600,0))
	_update_obstacles(trees)
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

func _add_obstacles(var start, var end, var obstacle_preload):
	var obstacles = []
	var last_obstacle = start
	while (last_obstacle < end):
		last_obstacle = last_obstacle + randi()%1000+100
		#print(last_obstacle)
		var obstacle = obstacle_preload.instance()
		obstacle.set_pos(Vector2(last_obstacle, 0))
		add_child(obstacle)
		obstacles.append(obstacle)
	return obstacles