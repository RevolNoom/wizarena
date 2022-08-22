extends Node2D


func _ready():
	set_process_input(false)

# TODO:
func PrepareSpell(spell):
	_spellInWeaving = spell
	PutStarsOnTable(spell.GetRandomizedStarList())
	spell.ActivateStarsInputProcessing()
	set_process_input(true)
	
func PutStarsOnTable(arrayOfStars):
	_starsOnTable = arrayOfStars
	# TODO: RAND with overlap checking
	# RAND with table size
	for star in _starsOnTable:
		var pos =  Vector2(rand_range(-100, 100), rand_range(-100, 100))
		star.position = pos
		add_child(star)

# Handle for GlobalState
# when spell is done or failed
func CleanUp():
	
	# Try to finish cleaning up the table before jumping to spell
	var spell = _spellInWeaving
	_spellInWeaving = null
	
	_isWeaving = false 
	
	for star in _starsOnTable:
		remove_child(star)
	set_process_input(false)
	
	spell.DeactivateStarsInputProcessing()
	
	
func _on_AstralTable_mouse_unpress():
	print("Spell failed: Mouse unpress before all stars are drawn.")
	GlobalState.StopWeavingProcedure()
	
func _on_AstralTable_mouse_exited():
	if _isWeaving and _spellInWeaving != null:
		print("Spell failed: Mouse goes off table before all stars are drawn")
		GlobalState.StopWeavingProcedure()
	

# Process mouse movement here
func _on_AstralTable_input_event(_viewport, event, _shape_idx):
	
	#TODO: I can optimize a few instructions here
	# But for the sake of readability, I won't
	
	if _spellInWeaving == null:
		return
		
	# Logic when user unpress mouse
	if _isWeaving and \
		((event is InputEventMouseButton and not event.pressed) or \
		(event is InputEventMouseMotion and event.pressure == 0)):
			_on_AstralTable_mouse_unpress()
	
	# Logic when user starts pressing mouse
	if not _isWeaving and \
		((event is InputEventMouseButton and event.pressed) or \
		(event is InputEventMouseMotion and event.pressure != 0)):
			_isWeaving = true
	

# When the player has start pressed and hold the mouse
# It's considered weaving 
var _isWeaving = false
var _spellInWeaving
var _starsOnTable

