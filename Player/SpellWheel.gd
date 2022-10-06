extends Node2D

signal spell_chosen(spell)

#TODO: There's add new spell, there should be remove spell
func _ready():
	for spell in [$SpellFireball, $Seisme]:
		remove_child(spell)
		AddNewSpell(spell)


func AddNewSpell(newSpell: Spell):
	var emptyslot = FindEmptySlot()
	if emptyslot == null:
		print("Can't find empty slot")
		return
		
	emptyslot.RefersTo(newSpell)
	
func GetSlots():
	var slots = []
	for i in range(1, 7):
		slots.push_back(get_node("Slot"+str(i)))
	return slots
	
	
func FindEmptySlot():
	for slot in GetSlots():
		if slot.IsEmpty():
			return slot
	return null
	
	
var _isHolding = false
func _unhandled_input(event):
	if event is InputEventMouseButton:
		_isHolding = event.pressed
		global_position = event.global_position
	
	if not visible and _isHolding and event is InputEventMouseMotion :
		OpenWheel()
	
	elif visible and not _isHolding:
		CloseWheel()
		for slot in GetSlots():
			var slotIsChosen = slot.IsChosen()
			if slotIsChosen != null:
				emit_signal("spell_chosen", slotIsChosen)

func OpenWheel():
	visible = true
	
	
func CloseWheel():
	visible = false


func Disable():
	CloseWheel()
	set_process_unhandled_input(false)
	
	
func Reenable():
	set_process_unhandled_input(true)
