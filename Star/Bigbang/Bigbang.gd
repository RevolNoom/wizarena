extends Blackhole


func DoTouchedBehaviors():
	_BlastStarsOut()


func _BlastStarsOut():
	for star in $EffectRadius.get_overlapping_bodies():
		star.apply_central_impulse((star.global_position - global_position).normalized() * TOUCH_IMPULSE)
