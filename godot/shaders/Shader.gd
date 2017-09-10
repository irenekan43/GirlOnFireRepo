extends Node2D

onready var shader_frame = get_node("BackBufferCopy/ShaderFrame")
onready var shader
var N = 0

func _ready():
	set_process(true)

func _process(delta):
	#set value of N (intensity of shader)
	#N = get_node(...).get("GLOBAL HP")
	shader_frame.set("material/material/shader_param/n", N)
	
	
