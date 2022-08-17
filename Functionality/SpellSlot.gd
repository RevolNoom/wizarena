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
	
var _isHoveredOn
func _on_Button_mouse_entered():
	_isHoveredOn = true
	
func _on_Button_mouse_exited():
	_isHoveredOn = false
	
func _on_mouse_unclick():
	if _isHoveredOn:
		GlobalState.get_node("AstralTable").PrepareSpell(_spell)
	_isHoveredOn = false
	
