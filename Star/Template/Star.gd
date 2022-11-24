extends RigidBody2D

class_name Star


# Emits when this star is touched
signal touched(selfStar)


# Called when the node enters the scene tree for the first time.
func _ready():
	Reset()


# OVERRIDE ME
# Called when the mouse touches this star
func DoTouchedBehaviors():
	pass


# OVERRIDE ME
func DoSwitchToTouchedState():
	_touched = true


func Reset():
	_touched = false


func IsTouched():
	return _touched


func _on_Star_mouse_entered():
	DoTouchedBehaviors()
	if not _touched:
		DoSwitchToTouchedState()
		emit_signal("touched", self)


var _touched:= bool(false)
