extends Path2D

#TODO: There's add new spell, there should be remove spell

func _ready():
	AddNewSpell($SpellFireball)

func AddNewSpell(newSpell: Spell):
	var emptyslot = FindEmptySlot()
	if emptyslot == null:
		print("Can't find empty slot")
		return
		
	emptyslot.RefersTo(newSpell)
	
func GetSlots():
	var slots = []
	for i in range(0, 8):
		slots.push_back(get_node("SpellSlot"+str(i)))
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
		NotifySlotsOnMouseUnclick()
		CloseWheel()

func OpenWheel():
	visible = true
	
func CloseWheel():
	visible = false

# See SpellSlot for reason why I have to do this
func NotifySlotsOnMouseUnclick():
	for slot in GetSlots():
		slot._on_mouse_unclick()
	
func DisableUntilAstralTableDone():
	CloseWheel()
	set_process_unhandled_input(false)
	
# Handle to call from AstralTable
func Reenable():
	set_process_unhandled_input(true)
