extends Star

class_name Blackhole	

export var touch_pull_impulse = 150
#TODO: space_override doesn't work when set at runtime


func Reset():
	.Reset()
	$Touched.visible = false
	$Touchable.visible = true
	$Gravity/Halo.visible = false
	

func DoSwitchToTouchedState():
	.DoSwitchToTouchedState()
	$Touched.visible = true
	$Touchable.visible = false
	$Gravity/Halo.visible = true
	
	
func DoTouchedBehaviors():
	.DoTouchedBehaviors()
	for star in $TouchAreaEffect.get_overlapping_bodies():
		star.apply_central_impulse((global_position - star.global_position).normalized() * touch_pull_impulse)
