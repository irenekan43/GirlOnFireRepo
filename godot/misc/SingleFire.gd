extends Sprite

var delay = 0

func _ready():
	set_process(true)

func _process(delta):
	delay += 1
	if (delay == 10):
		delay = 0
		set_frame((get_frame() + 1) % get_hframes())	