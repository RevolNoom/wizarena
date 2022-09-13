extends Star

func Reset():
	.Reset()
	
	for nlstar in _nonLockedStars:
		nlstar.disconnect("touched", self, "_on_InnerRim_touched") 
	_nonLockedStars = []
	_lockedStars = []


func _on_Star_touched(star):
	if star == self:
		if _nonLockedStars.size() == 0:
			return
			
		for s in _lockedStars:
			s.BeLockedBy(self)
		
		for s in _nonLockedStars:
			s.connect("touched", self, "_on_InnerRim_touched")

	else:
		star.disconnect("touched", self, "_on_InnerRim_touched")
		_nonLockedStars.erase(star)
		if _nonLockedStars.size() == 0:
			emit_signal("unlock", self)


func LockStars(starList):
	_lockedStars = starList.duplicate(true)
	_lockedStars.erase(self)

		
func _on_InnerRim_touched(star):
	_nonLockedStars.erase(star)
	star.disconnect("touched", self, "_on_InnerRim_touched") 
	if _nonLockedStars.size() == 0:
		emit_signal("unlock", self)


func _on_LockRadius_area_entered(star):
	
	if not star is Star or star == self or star.IsTouched():
		return
		
	_nonLockedStars.append(star)
	_lockedStars.erase(star)


var _nonLockedStars = []
var _lockedStars = []
