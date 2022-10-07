extends Node2D

#TODO: free() _spellBookCopy properly?

signal spell_chosen(spell)

func _ready():
	_spellBookCopy = GlobalSettings._EquippedSpells.duplicate(true)
	
	for i in _spellBookCopy:
		i.visible = true
	
	for i in range(0, get_child_count()):
		var spell = _spellBookCopy.pop_front()
		get_node("Slot" + str(i)).RefersTo(spell)


var _isHolding = false
func _unhandled_input(event):
	if event is InputEventMouseButton:
		_isHolding = event.pressed
		global_position = event.global_position
	
	if not visible and _isHolding and event is InputEventMouseMotion :
		OpenWheel()
	
	elif visible and not _isHolding:
		CloseWheel()
		for slot in get_children():
			if slot.IsChosen():
				emit_signal("spell_chosen", slot.GetSpell())


func PopSpellOffWheel(spell):
	var slot = spell.get_parent()
	slot.remove_child(spell)
	slot.add_child(_spellBookCopy.pop_front())
	_spellBookCopy.push_back(spell)


func OpenWheel():
	visible = true
	
	
func CloseWheel():
	visible = false


func Disable():
	CloseWheel()
	set_process_unhandled_input(false)
	
	
func Reenable():
	set_process_unhandled_input(true)
	

var _spellBookCopy
