extends Node2D

# TODO:
func PrepareSpell(spell):
	pass
	
func PutStarsOnTable(arrayOfStars):
	pass

# Handle for Spell to call 
# when spell is done or failed
func Cleanup():
	pass
	
func _on_AstralTable_mouse_unpress():
	_spellInWeaving._on_MouseUnpress()
	
func _on_AstralTable_mouse_exited():
	# TODO: Check if we are currently weaving a spell
	_spellInWeaving._on_MouseOffTable()

# Process mouse movement here
func _on_AstralTable_input_event(viewport, event, shape_idx):
	pass # Replace with function body.


# When the player has drawn on at least one star
# It's considered weaving 
var _isWeaving = false
var _spellInWeaving
