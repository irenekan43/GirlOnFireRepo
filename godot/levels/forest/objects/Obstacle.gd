extends Node2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func update(var girl_position):
	var proximity = max(get_pos().x - girl_position, 0)
	set_opacity(proximity/200)
	#print("hi: %s %s" % [self, proximity])
