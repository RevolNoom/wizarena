extends Star

class_name Blackhole

func Reset():
	.Reset()
	
	if $LockRadius.is_connected("body_entered", self, "_on_LockRadius_body_entered"):
		$LockRadius.disconnect("body_entered", self, "_on_LockRadius_body_entered")
		
	for nlstar in _nonLockedStars:
		if nlstar.is_connected("locked", self, "TryUnlock"):
			nlstar.disconnect("touched", self, "TryUnlock") 
			nlstar.disconnect("locked", self, "TryUnlock")
	_nonLockedStars = []
	_lockedStars = []
	

func _on_Star_touched(_star):
	if not TestLockCondition():
		return
		
	for s in _lockedStars:
		s.BeLockedBy(self)
	
	for s in _nonLockedStars:
		s.connect("touched", self, "TryUnlock")
		s.connect("locked", self, "TryUnlock")


func LockStars(starList):
	$LockRadius.connect("body_entered", self, "_on_LockRadius_body_entered")
	_fullStarList = starList.duplicate(true)
	_lockedStars = starList.duplicate(true)
	_lockedStars.erase(self)
	
	
func _on_LockRadius_body_entered(star):
	if not star is Star or star == self:
		return

	_nonLockedStars.append(star)
	_lockedStars.erase(star)


# Return true if there's at least one condition star touchable after lock
func TestLockCondition():
	for nls in _nonLockedStars:
		if nls.IsTouchable():
			return true
	return false

func TryUnlock(_star):
	if TestUnlockCondition():
		emit_signal("unlock", self)


# Return true when there's no star in valid state to draw on or
# if all condition stars are touched
func TestUnlockCondition():
	var allIsUntouchable = true
	for fsl in _fullStarList:
		if fsl.IsTouchable():
			allIsUntouchable = false
	
	if allIsUntouchable:
		return true

	for nls in _nonLockedStars:
		if not nls.IsTouched():
			return false
			
	return true

var _nonLockedStars = []
var _lockedStars = []
var _fullStarList = []
