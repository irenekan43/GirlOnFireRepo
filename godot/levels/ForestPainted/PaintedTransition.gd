extends Node

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

var bg1
var bg2
var bg3

func _ready():
	bg1 = get_node("BG1")
	bg2 = get_node("BG2")
	bg3 = get_node("BG3")
	set_process(true)

func _process(delta):
	if (bg1.get_opacity() > 0):
		_swap_opacity(delta, bg1, bg2)
	else:
		_swap_opacity(delta, bg2, bg3)

func _swap_opacity(var delta, var hide, var show):
	var opacityHide = hide.get_opacity()
	var opacityShow = show.get_opacity()
	opacityHide = max(opacityHide - delta/20, 0)
	opacityShow = min(opacityShow + delta/20, 1)
	hide.set_opacity(opacityHide)
	show.set_opacity(opacityShow)
