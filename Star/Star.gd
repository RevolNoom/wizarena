extends Area2D

class_name Star
# Should unlock stars that this one locked
signal unlock(selfStar)

# Emits when this star is touched in valid state
signal touched(selfStar)

# Emits when this star is touched in invalid state
signal invalid(selfStar)

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
	Deactivate()
	Reset()

# OVERRIDE ME
func LockStars():
	pass
	
# OVERRIDE ME
func _on_Star_touched(_star):
	pass
	

# TODO: Reset will be called by Spell
# after each completed weaving
# to set them back mint state
func Reset():
	_locks = 0
	$Sprite.texture = touchable_texture



func Activate():
	_locks = 0
	monitorable = true
	monitoring = true


func Deactivate():
	input_pickable = false
	monitorable = false
	monitoring = false

# A Locked star will fail the spell when player draws on it
# Many stars can lock one star
func IsLocked():
	return _locks > 0
	
# A Touchable star turns Touched when player draws on it
func IsTouchable():
	return _locks == 0
	
# A Touched Star cannot be locked by any other star logic
# Example could be Black Hole, Sun, Vector
func IsTouched():
	return _locks == -1


func BeLockedBy(anotherStar):
	if not IsTouched():
		_locks += 1
		var err = anotherStar.connect("unlock", self, "_on_Star_unlock")
		$Sprite.texture = locked_texture
		

func _on_Star_unlock(locker):
	locker.disconnect("unlock", self, "_on_Star_unlock")
	if IsTouchable():
		$Sprite.texture = touchable_texture


func _on_Star_input_event(_viewport, event, _shape_idx):
	if not event is InputEventMouse:
		return

	if IsLocked():
		emit_signal("invalid", self)
		return 
		
	if IsTouchable():
		$Sprite.texture = touched_texture
		Deactivate()
		_locks = -1
		emit_signal("touched", self)
		emit_signal("unlock", self)

# The number of stars that are locking us
var _locks = 0

export(StreamTexture) var touchable_texture
export(StreamTexture) var touched_texture
export(StreamTexture) var locked_texture

