extends RigidBody2D

class_name Star
# Emit when this star unlocks other stars
signal unlock(selfStar)

# Emits when this star is touched in valid state
signal touched(selfStar)

# Emits when this star is touched in invalid state
signal invalid(selfStar)

# Emits when this star becomes locked
signal locked(selfStar)

# Emits when this star becomes locked
signal unlocked(selfStar)

# The number of stars that are locking us
var _locks = []
var _state = STATE.UNTOUCHED
var _readonlyStarList
enum STATE{
	UNTOUCHED
	TOUCHED
}
# Astral Table Method call chain:
# Reset(): Put star back to touchable state. 
# LockStars()
# [BeLockedBy()]
# Activate(): Start receiving mouse event for gameplay
# Deactivate(): When the star is touched
# 

# Called when the node enters the scene tree for the first time.
func _ready():
	connect("touched", self, "_on_Star_touched")
	input_pickable = false
	Reset()

# OVERRIDE ME
func LockStars(starList):
	pass
	
	
# OVERRIDE ME
func _on_Star_touched(_star):
	pass


# Called when a star of interest emits "locked"
# Return true when this star has all condition stars touched
# or when there's no touchable star on AstralTable
func TestUnlockCondition():
	return false


# TODO: Reset will be called by Spell
# after each completed weaving
# to set them back mint state
func Reset():
	_state = STATE.UNTOUCHED
	$Sprite.texture = touchable_texture
	for l in _locks:
		l.disconnect("unlock", self, "_on_Star_unlock")
	_locks = []

func IsLocked():
	return _locks.size() > 0
	
# A Touchable star turns Touched when player draws on it
func IsTouchable():
	return _locks.size() == 0 and _state == STATE.UNTOUCHED
	
# A Touched Star cannot be locked by any other star logic
# Example could be Black Hole, Sun, Vector
func IsTouched():
	return _state == STATE.TOUCHED


func BeLockedBy(anotherStar):
	if not IsTouched():
		_locks.append(anotherStar)
		var err = anotherStar.connect("unlock", self, "_on_Star_unlock")
		$Sprite.texture = locked_texture
		emit_signal("locked", self)
		

func _on_Star_unlock(locker):
	locker.disconnect("unlock", self, "_on_Star_unlock")
	_locks.erase(locker)
	if IsTouchable():
		$Sprite.texture = touchable_texture
		emit_signal("unlocked", self)
	


func _on_Star_input_event(_viewport, event, _shape_idx):
	if not event is InputEventMouse:
		return
	
	
	print(name)
	
	if IsLocked():
		emit_signal("invalid", self)
		
		
	elif IsTouchable():
		_state = STATE.TOUCHED
		$Sprite.texture = touched_texture
		input_pickable = false
		emit_signal("touched", self)


export(StreamTexture) var touchable_texture
export(StreamTexture) var touched_texture
export(StreamTexture) var locked_texture


