extends Node2D

# class member variables go here, for example:
export(int) var widths_left
export(int) var widths_right
export(Texture) var texture

var parallax_base

func parallax_translate(var delta_girl_speed):
	parallax_base.translate(Vector2(delta_girl_speed*(500-get_z()),0))

func _ready():
	parallax_base = Node2D.new()
	for x in range(-widths_left, widths_right):
		var tile = Sprite.new()
		tile.set_texture(texture)
		tile.set_pos(Vector2(x*texture.get_width(),0))
		parallax_base.add_child(tile)
	add_child(parallax_base)