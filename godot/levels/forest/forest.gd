extends Node2D

const BACKGROUND = preload("res://levels/forest/ground.png")
const SKY = preload("res://levels/forest/sky.png")

const TREE = preload("res://levels/forest/objects/Tree.tscn")

#environment
var tiles
var tiles_sky

#obstacles
var trees

#misc
var girl

func _ready():
	girl = get_node("Girl")
	var camera = get_node("Girl/Camera2D").get_viewport_rect()
	#print(camera)
	#print(get_viewport().get_visible_rect())
	#print(BACKGROUND.get_size())
	var viewport_width = get_viewport_rect().size.x
	var background_width = BACKGROUND.get_width()
	
	tiles = []
	tiles_sky = []
	
	#print(viewport_width)
	print(background_width)
	
	var min_range = ceil(viewport_width/2/background_width)
	var max_range = min_range*10
	print("[forest.tscn]: range(%s,%s)" % [-min_range, max_range])
	
	var max_dist = max_range*SKY.get_width()
	print(max_dist)
	
	for x in range(-min_range, max_range):
		var sky = Sprite.new()
		sky.set_texture(SKY)
		sky.set_pos(Vector2(x*SKY.get_width(),0))
		add_child(sky)
		tiles_sky.append(sky)

	trees = _add_obstacles(0, max_dist, TREE)

	# floor layer over everything else
	for x in range(-min_range, max_range):
		var tile = Sprite.new()
		tile.set_texture(BACKGROUND)
		tile.set_pos(Vector2(x*BACKGROUND.get_width(),0))
		add_child(tile)
		tiles.append(tile)
	
	girl.set_z(100)
	set_process(true)

func _process(delta):
	girl.translate(Vector2(delta*500, 0))
	#print(girl.get_pos().x)
	#print(delta)

func _add_obstacles(var start, var end, var obstacle_preload):
	var obstacles = []
	var last_obstacle = start
	while (last_obstacle < end):
		last_obstacle = last_obstacle + randi()%1000+100
		print(last_obstacle)
		var obstacle = obstacle_preload.instance()
		obstacle.set_pos(Vector2(last_obstacle, 0))
		add_child(obstacle)
		obstacles.append(obstacle)
	return obstacles