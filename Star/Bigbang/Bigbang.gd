extends Star

export var touch_blast_impulse = 250

func DoTouchedBehaviors():
	$TouchBlast/Halo.Play()
	for star in $TouchBlast.get_overlapping_bodies():
		star.apply_central_impulse((star.global_position - global_position).normalized() * touch_blast_impulse)
