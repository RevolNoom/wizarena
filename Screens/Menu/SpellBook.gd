extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	for i in _spellBook.keys():
		$HBoxContainer/VBoxContainer/ItemList.add_icon_item(_spellBook[i].get_texture())

	for slot in $HBoxContainer/Panel/MilkyWay.get_children():
		slot.add_child(preload("res://Spell/Mystery/Mystery.tscn").instance())



func _on_ItemList_item_selected(index):
	$HBoxContainer/VBoxContainer/DescriptionText.text = _spellBook[index].description


var _spellBook = {
	#-1 : preload("res://Spell/Mystery/Mystery.tscn").instance(),
	0 : preload("res://Spell/Fireball/Fireball.tscn").instance(),
	1 : preload("res://Spell/Seisme/Seisme.tscn").instance(),
	}


# ItemList item is only activated at triple-clicking
func _on_ItemList_item_activated(index):
	_on_ItemList_item_selected(index)
	var spell = _spellBook[index].duplicate()
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
	$HBoxContainer/Panel/MilkyWay.position = $HBoxContainer/Panel/MilkyWay.get_parent().rect_size / 2
