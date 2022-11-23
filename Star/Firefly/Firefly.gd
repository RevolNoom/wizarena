extends Star


const TOUCH_IMPULSE = 500


func Reset():
	.Reset()
	$Touchable.visible = true
	$Touched.visible = false
	$Halo.visible = false
	

func DoSwitchToTouchedState():
	.DoSwitchToTouchedState()
	$Touchable.visible = false
	$Touched.visible = true
	$Halo.visible = true
	
	
func DoTouchedBehaviors():
	.DoTouchedBehaviors()
	apply_central_impulse(-get_local_mouse_position().normalized()*TOUCH_IMPULSE)
