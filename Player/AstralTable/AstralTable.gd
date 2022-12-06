# Control spell drawing rule
# Borrow (then return) Stars from Spell 
# Draw Stars on table

extends Node2D

signal done


func StartWeaving(spell):
	_spellInWeave = spell
	visible = true
	PutStarsOnTable(spell.StarList)
	_on_AstralTable_item_rect_changed()
	$Wand.Activate(spell)


func StopWeaving():
	_spellInWeave = null
	visible = false
	for star in $Stars.get_children():
		$Stars.remove_child(star)
	$Wand.Deactivate()


func PutStarsOnTable(starList):
	# TODO: RAND with overlap checking
	# RAND with table size
	for star in starList:
		$Stars.add_child(star)
		star.Reset()
		star.position = Vector2(rand_range(-100, 100), rand_range(-100, 100))


func _on_Wand_done():
	emit_signal("done", _spellInWeave)


func _on_AstralTable_item_rect_changed():
	global_position = get_viewport().get_visible_rect().size / 2


var _spellInWeave



