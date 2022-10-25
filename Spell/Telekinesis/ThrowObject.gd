extends Area2D

var _pickedObject = null
onready var Mouse = $Mouse

func GetPlayer():
	return get_node_or_null("../..")


func _on_ThrowObject_body_exited(body):
	if body == _pickedObject:
		_pickedObject = null


func _unhandled_input(event):
	get_tree().set_input_as_handled()
	if event is InputEventMouseMotion:
		Mouse.global_position = Mouse.get_global_mouse_position()
		
	elif event is InputEventMouseButton and event.is_pressed():# \
		#or (event is InputEventKey and event.scancode = ord(' '):
		
		#print("clicked")
		
		if _pickedObject == null:
			if Mouse.get_overlapping_bodies().size() == 0:
				return
				
			_pickedObject = Mouse.get_overlapping_bodies()[0]
			if not _pickedObject in get_overlapping_bodies():
				_pickedObject = null

		else:
			GetPlayer().rpc("CastSpell", "res://Spell/Telekinesis/Telekinesis.tscn",\
								[_pickedObject.get_path(),
								(Mouse.global_position - _pickedObject.global_position).normalized()])
			CleanUp()


func CleanUp():
	pass
	#get_parent().remove_child(self)
	#queue_free()
