# Control spell drawing rule
# Borrow (then return) Stars from Spell 
# Draw Stars on table

extends Node2D

signal done


func _ready():
	set_process_input(false)


func StartWeaving(spell):
	_starList.append_array(spell.StarList)
	_starCount = 0
	PutStarsOnTable()
	set_process_input(true)
	visible = true


func StopWeaving():
	for star in _starList:
		star.disconnect("touched", self, "_on_Star_touched")
		remove_child(star)
	_starList.clear()
	set_process_input(false)
	visible = false


func PutStarsOnTable():
	# TODO: RAND with overlap checking
	# RAND with table size
	for star in _starList:
		add_child(star)
		star.Reset()
		star.connect("touched", self, "_on_Star_touched")
		star.position = Vector2(rand_range(-100, 100), rand_range(-100, 100))


func _on_AstralTable_draw():
	# Put itself in the middle of the screen
	global_position = get_viewport().get_visible_rect().size / 2


func _on_Star_touched(_star):
	_starCount += 1
	if _starCount == _starList.size():
		StopWeaving()
		emit_signal("done")


var _starList:= []
var _starCount:= 0
