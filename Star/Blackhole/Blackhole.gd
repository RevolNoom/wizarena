extends Star

class_name Blackhole	

export var touch_pull_impulse = 200


#func Reset():
#	.Reset()
	
#TODO: space_override doesn't work when set at runtime

func DoTouchedBehaviors():
	.DoTouchedBehaviors()
	for star in $TouchPull.get_overlapping_bodies():
		star.apply_central_impulse((global_position - star.global_position).normalized() * touch_pull_impulse)


#func DoSwitchToTouchedState():
#	.DoSwitchToTouchedState()
