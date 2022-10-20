# Control spell drawing rule
# Borrow (then return) Stars from Spell 
# Draw Stars on table

extends Node2D

signal end_weave(spell)
signal spell_changed(spell)

func _ready():
	set_process_input(false)


func StartWeaving(spell):
	_spellInWeaving = spell
	_starList = spell.StarList.duplicate(true)
	#print("Table " + spell.name + " stars: " + str(_starList))
	_starCount = 0
	PutStarsOnTable()
	ActivateStarsDependencies()
	set_process_input(true)
	visible = true


func StopWeaving():
	_isWeaving = false 
	DeactivateStarsInput()
	
	for star in _starList:
		star.disconnect("touched", self, "_on_Star_touched")
		star.disconnect("invalid", self, "_on_Star_invalid")
		remove_child(star)
	_starList = null
	set_process_input(false)
	
	visible = false
	
	var spell = _spellInWeaving
	_spellInWeaving = null
	emit_signal("end_weave", spell)


func PutStarsOnTable():
	# TODO: RAND with overlap checking
	# RAND with table size
	for star in _starList:
		star.Reset()
		var pos =  Vector2(rand_range(-100, 100), rand_range(-100, 100))
		star.position = pos
		add_child(star)
		star.connect("touched", self, "_on_Star_touched")
		star.connect("invalid", self, "_on_Star_invalid")


func ActivateStarsDependencies():
	for s in _starList:
		s.LockStars(_starList)
	
	
func ActivateStarsInput():
	for star in _starList:
		star.input_pickable = true


func DeactivateStarsInput():
	for star in _starList:
		star.input_pickable = false


func _on_AstralTable_mouse_unpress():
	print("Spell failed: Mouse unpress before all stars are drawn.")
	StopWeaving()


func _on_AstralTable_mouse_exited():
	if _isWeaving and _spellInWeaving != null:
		print("Spell failed: Mouse goes off table before all stars are drawn")
		StopWeaving()


func SpellWoven():
	emit_signal("spell_changed", _spellInWeaving)
	StopWeaving()


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
			ActivateStarsInput()


func _on_AstralTable_draw():
	# Put itself in the middle of the screen
	global_position = get_viewport().get_visible_rect().size / 2


func _on_Star_invalid(_star):
	print("Spell failed: Mouse touched invalid star")
	StopWeaving()


func _on_Star_touched(_star):
	_starCount += 1
	if _starCount == _starList.size():
		SpellWoven()


# When the player has start pressed and hold the mouse
# It's considered weaving 
var _isWeaving = false
var _spellInWeaving
var _starList
var _starCount
