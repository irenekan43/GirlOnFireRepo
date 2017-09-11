extends CollisionObject2D

export(int) var hp

const SINGLE_FIRE = preload("res://misc/SingleFire.tscn")

func _input_event(viewport, event, shape_idx):
	if (event.type == InputEvent.MOUSE_BUTTON && event.is_pressed()):
		if (hp > 0):
			hp = hp - 1
			if (hp == 0):
				set_opacity(0)
			else:
				#print(self.get_pos())
				#print(event.pos)
				var fire = SINGLE_FIRE.instance()
				var sprite = get_node("Sprite")
				sprite.add_child(fire)
				#fire.set_pos(Vector2(0, event.pos.y - get_pos().y))
				fire.set_z(sprite.get_z()+1)
				
				#print(self.get_name())
				#print(fire.get_pos())
				

func update(var girl_position):
	if (get_pos().x > 19200):
		set_opacity(0)
	if (hp == 0):
		return
	var proximity = max(get_pos().x - girl_position, 0)
	set_opacity(proximity/200)
	
	#print("hi: %s %s" % [self, proximity])

