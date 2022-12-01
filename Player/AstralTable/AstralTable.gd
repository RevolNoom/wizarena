# Control spell drawing rule
# Borrow (then return) Stars from Spell 
# Draw Stars on table

extends Node2D

signal done


func StartWeaving(spell):
	PutStarsOnTable(spell.StarList)
	visible = true
	_on_AstralTable_item_rect_changed()
	$Wand.Activate(spell)


func StopWeaving():
	for star in $Stars.get_children():
		$Stars.remove_child(star)
	visible = false
	$Wand.Deactivate()


func PutStarsOnTable(starList):
	# TODO: RAND with overlap checking
	# RAND with table size
	for star in starList:
		$Stars.add_child(star)
		star.Reset()
		#star.connect("touched", self, "_on_Star_touched")
		star.position = Vector2(rand_range(-100, 100), rand_range(-100, 100))


func _on_Wand_done():
	StopWeaving()
	emit_signal("done")


func _on_AstralTable_item_rect_changed():
	global_position = get_viewport().get_visible_rect().size / 2





