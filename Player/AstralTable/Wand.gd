extends Area2D

signal done


func _ready():
	Deactivate()


func Activate(spell):
	_starCount = spell.StarList.size()
	global_position = get_global_mouse_position()
	set_process_unhandled_input(true)


func Deactivate():
	set_process_unhandled_input(false)


func _unhandled_input(event):
	if event is InputEventMouseMotion:
		global_position = event.global_position


func _on_Wand_body_entered(body):
	if not body.IsTouched():
		_starCount -= 1
	body.OnWandTouch()
	
	# These lines are put after OnWandTouch
	if _starCount == 0:
		emit_signal("done")


func GetTip():
	return $Wandtip.global_position


var _starCount:= 0
