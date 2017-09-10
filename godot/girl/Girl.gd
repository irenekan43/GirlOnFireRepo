extends Node2D

var girl
var girl_sprite
var girl_speed
var fire_sprite

const WALK_SHEET = preload("girl walk cycle sheet.png")
const GIRL_REST = preload("girl resting.png")

func get_girl_speed():
	return girl_speed

func _ready():
	girl = get_node(".")
	girl_sprite = get_node("Node2D/Girl")
	fire_sprite = get_node("Node2D/On Fire")
	#girl_sprite.play()
	girl_speed = 250
	#var camera = get_node("./Camera2D").get_viewport_rect()
	#print(camera)
	set_process_input(true)
	set_process(true)

func _input(event):
	if (event.is_pressed()):
		if (event.is_action("ui_left")):
			girl_speed = max(0, girl_speed - 100)
		if (event.is_action("ui_right")):
			girl_speed = min(500, girl_speed + 5)

func _process(delta):
	if (get_pos().x >= 19240):
		girl_speed = 0
	_animate_girl_walk(delta)
	_animate_fire(delta)

# struggle manual animate since setting animation speed gets stuck sometimes
# girl_sprite.get_sprite_frames().set_animation_speed("girlwalk1_250", sprite_speed)
var elapse_sec = 0
func _animate_girl_walk(var delta):
	if (girl_speed == 0):
		girl_sprite.set_frame(0)
		girl_sprite.set_hframes(1)
		girl_sprite.set_texture(GIRL_REST)
		return
	elif (girl_sprite.get_texture() != WALK_SHEET):
		girl_sprite.set_hframes(4)
		girl_sprite.set_texture(WALK_SHEET)
	
	var girl_speed_fps = girl_speed/50.0 + 0.0001
	elapse_sec = elapse_sec + delta
	if (elapse_sec > 1 / girl_speed_fps):
		elapse_sec = 0
		var frame_count = girl_sprite.get_hframes()
		girl_sprite.set_frame((girl_sprite.get_frame()+1) % frame_count)

var fire_cycle = 0
func _animate_fire(var delta):
	fire_cycle = fire_cycle + delta
	if (fire_cycle > 0.2):
		fire_cycle = 0
		var frame_count = fire_sprite.get_hframes()
		fire_sprite.set_frame((fire_sprite.get_frame()+1) % frame_count)
		