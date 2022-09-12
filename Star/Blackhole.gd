extends Star

func Reset():
	.Reset()
	for lstar in _lockedStars:
		disconnect("unlock", lstar, "_on_Star_unlock")
	_lockedStars = []
	
	for nlstar in _nonLockedStars:
		disconnect("touched", nlstar, "_on_OuterRim_touched") 
	_nonLockedStars = []
	

func _on_Star_touched(star):
	_nonLockedStars = $LockRadius.get_overlapping_areas()
	for star in _nonLockedStars:
		if not star is Star or star.IsTouched():
			_nonLockedStars.erase(star)
	_nonLockedStars.erase(self)
	if _nonLockedStars.size() == 0:
		return
				
	_lockedStars = _masterSpell._starList
	for star in _nonLockedStars:
		if not star.IsTouched():
			_lockedStars.erase(star)
	
	for star in _lockedStars:
		star.BeLockedBy(self)
	
	for star in _nonLockedStars:
		star.connect("touched", self, "_on_OuterRim_touched")
		
		
func _on_OuterRim_touched(star):
	_nonLockedStars.erase(star)
	disconnect("touched", star, "_on_OuterRim_touched") 
	if _nonLockedStars.size() == 0:
		emit_signal("unlock", self)

var _nonLockedStars = []
var _lockedStars = []
