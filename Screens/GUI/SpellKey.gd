extends TextureButton


export var _keyBinding = ""


func _unhandled_key_input(event):
	if event.pressed and event.scancode == ord(_keyBinding):
		emit_signal("pressed")
