extends Node2D

onready var shader_frame = get_node("HeatShader/HeatFrame")

func _ready():
	set_shader_opacity(0)

func set_shader_opacity(var opacity):
	#set value of N (intensity of shader)
	#N = get_node(...).get("GLOBAL HP")
	shader_frame.get_material().set_shader_param("n", opacity)