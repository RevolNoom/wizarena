extends RigidBody2D

class_name Star


# Called when the node enters the scene tree for the first time.
func _ready():
	Reset()


# OVERRIDE ME
# Called when the wand touches this star
func DoTouchedBehaviors():
	pass


# OVERRIDE ME
func DoSwitchToTouchedState():
	_touched = true


func Reset():
	_touched = false


func IsTouched():
	return _touched


func GetWand():
	return get_node("../../Wand")


# Called from Wand
func OnWandTouch():
	DoTouchedBehaviors()
	if not _touched:
		DoSwitchToTouchedState()


var _touched:= bool(false)
