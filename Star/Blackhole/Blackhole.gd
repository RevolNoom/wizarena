extends Star

class_name Blackhole	

#TODO: space_override doesn't work when set at runtime

func DoTouchedBehaviors():
	.DoTouchedBehaviors()
	_SuckStarsIn()


func _SuckStarsIn():
	for star in $EffectRadius.get_overlapping_bodies():
		star.apply_central_impulse((global_position - star.global_position).normalized() * TOUCH_IMPULSE)
	
