extends Blackhole


func DoTouchedBehaviors():
	for star in $TouchAreaEffect.get_overlapping_bodies():
		star.apply_central_impulse((star.global_position - global_position).normalized() * touch_pull_impulse)
