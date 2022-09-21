extends Star

func Reset():
	.Reset()
	
	if _nonLockedStar != null and _nonLockedStar.is_connected("locked", self, "TryUnlock"):
		_nonLockedStar.disconnect("touched", self, "TryUnlock") 
		_nonLockedStar.disconnect("locked", self, "TryUnlock")
	_nonLockedStar = null
	_lockedStars = []
	

func _on_Star_touched(_star):
	_nonLockedStar = PickFarthestTouchableStar()
	
	if _nonLockedStar == null:
		return
		
	_nonLockedStar.connect("touched", self, "TryUnlock")
	_nonLockedStar.connect("locked", self, "TryUnlock")

	_lockedStars.erase(_nonLockedStar)
	for ls in _lockedStars:
		ls.BeLockedBy(self)
	

func PickFarthestTouchableStar():
	var farthestStar = self
	
	for s in _lockedStars:
		if position.distance_to(s.position) > position.distance_to(farthestStar.position) and \
			s.IsTouchable():
			farthestStar = s
			
	if farthestStar != self:
		return farthestStar
	return null


func LockStars(starList):
	_lockedStars = starList.duplicate(true)
	_lockedStars.erase(self)
	
func TestUnlockCondition():
	if _nonLockedStar.IsTouched():
		return true
		
	# Since all other stars are locked, we don't need to test them
	return false

func TryUnlock(_star):
	if TestUnlockCondition():
		emit_signal("unlock", self)
			

var _nonLockedStar
var _lockedStars = []
