extends PathFollow2D


func RefersTo(newSpell: Spell):
	_spell = newSpell
	
	$Button/Sprite.texture = newSpell._icon_texture
	# TODO: Uniformly resize texture size
	# $Sprite.texture.get_size()
	
var _spell

# Two Signals to work-around a problem
# SpellWheel can intercept InputEventMouseButton
# but SpellSlot loses it
# I don't know why the click is not propagated to this button
# even though it can intercept MouseMotion
#func _on_Button_input_event(_viewport, event, _shape_idx):
#	print("Button" + str(event))
#	if event is InputEventMouseButton:
#		if event.pressed == false:
#			print("SetSpell")
	
func IsEmpty():
	return _spell == null
	
var _isHoveredOn
func _on_Button_mouse_entered():
	_isHoveredOn = true
	
func _on_Button_mouse_exited():
	_isHoveredOn = false
	
# Return the spell if it's hovered on and the slot is not empty
# After calling this function, the slot clears its state, any
# subsequent calls will return null, unless the slot is chosen again
# Return null otherwise
func IsChosen():
	if _isHoveredOn and not IsEmpty():
		_isHoveredOn = false
		return _spell
	return null
