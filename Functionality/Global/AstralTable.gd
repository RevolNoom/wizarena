extends Node2D


func _ready():
	set_process_input(false)

# TODO:
func PrepareSpell(spell):
	_spellInWeaving = spell
	PutStarsOnTable(spell.GetStarList())
	set_process_input(true)
	
func PutStarsOnTable(arrayOfStars):
	_starsOnTable = arrayOfStars
	# TODO: RAND with overlap checking
	# RAND with table size
	for star in _starsOnTable:
		var pos =  Vector2(rand_range(-100, 100), rand_range(-100, 100))
		star.position = pos
		add_child(star)

# Handle for Spell to call 
# when spell is done or failed
func CleanUp():
	_isWeaving = false
	_spellInWeaving = null
	for star in _starsOnTable:
		remove_child(star)
		star.Deactivate()
	set_process_input(false)
	
func _on_AstralTable_mouse_unpress():
	_spellInWeaving._on_MouseUnpress()
	GlobalState.StopWeavingProcedure()
	
func _on_AstralTable_mouse_exited():
	if _isWeaving and _spellInWeaving != null:
		_spellInWeaving._on_MouseOffTable()
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
			_spellInWeaving.StartWeaving()
	

# When the player has start pressed and hold the mouse
# It's considered weaving 
var _isWeaving = false
var _spellInWeaving
var _starsOnTable

