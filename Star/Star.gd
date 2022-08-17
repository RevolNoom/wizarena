extends Area2D

# Emits when this star is touched in valid state
# Should unlock stars that this one locked
signal unlock(selfStar)

# Called when the node enters the scene tree for the first time.
func _ready():
	Deactivate()

func SetMasterSpell(spell):
	_masterSpell = spell

func Activate():
	_locks = []
	input_pickable = true
	monitorable = true
	monitoring = true
	
func Deactivate():
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


func LockedBy(anotherStar):
	if not IsTouched():
		_locks.append(anotherStar)
		var err = connect("unlock", anotherStar, "_on_Star_unlock")

func _on_Star_unlock(locker):
	_locks.erase(locker)
	disconnect("unlock", locker, "_on_Star_unlock")


func _on_Star_input_event(_viewport, event, _shape_idx):
	if not event is InputEventMouse:
		return

	if IsLocked():
		_masterSpell.FailedByStarLock(self)
		return 
		
	if IsTouchable():
		$Sprite.modulate = $Sprite.modulate.lightened(0.2)
		Deactivate()
		_masterSpell._on_StarTouched(self)
		emit_signal("unlock")

var _masterSpell
var _locks
