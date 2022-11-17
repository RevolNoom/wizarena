extends Control

# Called when the node enters the scene tree for the first time.
func _ready():
	
	var startingSpells = [
		preload("res://Spell/Fireball/Fireball.tscn"), 
		#preload("res://Spell/Seisme/Seisme.tscn"),
		#preload("res://Spell/Telekinesis/Telekinesis.tscn")]
		]
	for i in _spellBook.keys():
		$VBoxContainer/ItemList.add_icon_item(_spellBook[i].get_texture())
		
	for i in range(0, 10):
		var eqs = startingSpells[i%startingSpells.size()].instance()
		$Panel/MilkyWay.get_child(i).add_child(eqs)
		eqs.visible = true


# Transfer Spells in slots to GlobalSettings' Spell Book
func GetSpells():
	var spells = []
	spells.resize(10)
	for i in range(0, 10):
		spells[i] = $Panel/MilkyWay.get_child(i).get_child(0)
	return spells
	

func _on_ItemList_item_selected(index):
	$VBoxContainer/DescriptionText.text = _spellBook[index].description


var _spellBook = {
	#-1 : preload("res://Spell/Mystery/Mystery.tscn").instance(),
	0 : preload("res://Spell/Fireball/Fireball.tscn").instance(),
	#1 : preload("res://Spell/Seisme/Seisme.tscn").instance(),
	#2 : preload("res://Spell/Telekinesis/Telekinesis.tscn").instance(),
	}


# ItemList item is only activated at triple-clicking
func _on_ItemList_item_activated(index):
	_on_ItemList_item_selected(index)
	var spell = _spellBook[index].duplicate()
	spell.visible = true
	_mousePosition.add_child(spell)
	
	

func _on_SpellBook_gui_input(event):
	if event is InputEventMouseMotion:
		_mousePosition.position = event.position
		
	if event is InputEventMouseButton:
		if event.pressed == false:
			for spell in _mousePosition.get_children():
				# Swap place with the first spell slot
				var overlap = spell.get_overlapping_areas()
				_mousePosition.remove_child(spell)
				if overlap.size() > 0:
					var ovl = overlap[0]
					var slot = ovl.get_parent()
					slot.remove_child(ovl)
					slot.add_child(spell)
					spell.position = Vector2(0, 0)
					ovl.queue_free()
				else:
					spell.queue_free()


onready var _mousePosition = $MousePosition


func _on_Panel_item_rect_changed():
	$Panel/MilkyWay.position = $Panel/MilkyWay.get_parent().rect_size / 2
