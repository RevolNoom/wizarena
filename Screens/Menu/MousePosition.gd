extends Position2D

func _process(delta):
	if global_position != get_global_mouse_position():
		global_position = get_global_mouse_position()
