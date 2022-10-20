extends Area2D

var _pickedObject = null
export var impulse = 100


func _on_ThrowObject_body_exited(body):
	if body == _pickedObject:
		_pickedObject = null


func _unhandled_input(event):
	if event is InputEventMouseMotion:
		$Mouse.position = event.position
	elif event is InputEventMouseButton:# \
		#or (event is InputEventKey and event.scancode = ord(' '):
		
		if _pickedObject == null:
			$Mouse.force_raycast_update()
			_pickedObject = $Mouse.get_collider()
			if not _pickedObject in get_overlapping_bodies():
				_pickedObject = null

		else:
			var direction = event.global_position - _pickedObject.global_position
			
			# Need RPC here
			_pickedObject.apply_central_impulse(direction.normalized() * impulse)
			CleanUp()


func CleanUp():
	pass
	#get_parent().remove_child(self)
	#queue_free()
