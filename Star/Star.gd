extends Area2D

class_name Star
# Emits when this star is touched in valid state
# Should unlock stars that this one locked
signal unlock(selfStar)

# Called when the node enters the scene tree for the first time.
func _ready():
	Deactivate()
	Reset()

func SetMasterSpell(spell):
	_masterSpell = spell

# TODO: Reset will be called by Spell
# after each completed weaving
# to set them back mint state
func Reset():
	$Sprite.texture = touchable_texture


# OVERRIDE ME
func LockStars():
	pass
	

func Activate():
	_locks = []
	monitorable = true
	monitoring = true


func Deactivate():
	if _locks != null:
		for l in _locks:
			_on_Star_unlock(l)
	_locks = null
	input_pickable = false
	monitorable = false
	monitoring = false

# A Locked star will fail the spell when player draws on it
# Many stars can lock one star
func IsLocked():
	return _locks.size()
	
# A Touchable star turns Touched when player draws on it
func IsTouchable():
	return _locks.size() == 0
	
# A Touched Star cannot be locked by any other star logic
# Example could be Black Hole, Sun, Vector
func IsTouched():
	return _locks == null


func BeLockedBy(anotherStar):
	if not IsTouched():
		_locks.append(anotherStar)
		var err = anotherStar.connect("unlock", self, "_on_Star_unlock")
		$Sprite.texture = locked_texture
		

func _on_Star_unlock(locker):
	_locks.erase(locker)
	locker.disconnect("unlock", self, "_on_Star_unlock")
	if IsTouchable():
		$Sprite.texture = touchable_texture


func _on_Star_input_event(_viewport, event, _shape_idx):
	if not event is InputEventMouse:
		return

	if IsLocked():
		_masterSpell.FailedByStarLock(self)
		return 
		
	if IsTouchable():
		$Sprite.texture = touched_texture
		Deactivate()
		_masterSpell._on_StarTouched(self)
		emit_signal("unlock", self)

var _masterSpell
var _locks

export(StreamTexture) var touchable_texture
export(StreamTexture) var touched_texture
export(StreamTexture) var locked_texture

