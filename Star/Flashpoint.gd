extends Star

func OnStarTouch():
	var allStars = _masterSpell._starList
	var nonLockedStars = $LockRadius.get_overlapping_areas()
	for star in allStars:
		if not star in nonLockedStars and star is Star and not star.IsTouched():
			 star.BeLockedBy(self)
