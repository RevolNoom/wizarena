extends Blackhole


func LockStars(starList):
	$LockRadius.connect("body_entered", self, "_on_LockRadius_body_entered")
	_nonLockedStars = starList.duplicate(true)
	_nonLockedStars.erase(self)


func _on_LockRadius_body_entered(star):
	if not star is Star or star == self or star.IsTouched():
		return
		
	_nonLockedStars.erase(star)
	_lockedStars.append(star)
