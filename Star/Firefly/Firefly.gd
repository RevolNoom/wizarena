extends Star


const TOUCH_IMPULSE = 500

func _ready():
	$Touchable.Play()
	$Touched.Play()

func Reset():
	.Reset()
	$Touchable.visible = true
	$Touched.visible = false
	

func DoSwitchToTouchedState():
	.DoSwitchToTouchedState()
	$Touchable.visible = false
	$Touched.visible = true
	
	
func DoTouchedBehaviors():
	.DoTouchedBehaviors()
	apply_central_impulse(-get_local_mouse_position().normalized()*TOUCH_IMPULSE)
