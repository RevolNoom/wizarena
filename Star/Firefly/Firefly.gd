extends Star

# TODO: How to make the firefly fly away from mouse
# But doesn't get stuck on the edge of the table?

func Reset():
	.Reset()
	set_physics_process(true)
	

func DoSwitchToTouchedState():
	.DoSwitchToTouchedState()
	set_physics_process(false)


func _physics_process(delta):
	pass
