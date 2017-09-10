extends CollisionObject2D

export(int) var hp

func _input_event(viewport, event, shape_idx):
	if (event.type == InputEvent.MOUSE_BUTTON && event.is_pressed()):
		if (hp > 0):
			hp = hp - 1
			if (hp == 0):
				set_opacity(0)

func update(var girl_position):
	if (hp == 0):
		return
	var proximity = max(get_pos().x - girl_position, 0)
	set_opacity(proximity/200)
	
	#print("hi: %s %s" % [self, proximity])

