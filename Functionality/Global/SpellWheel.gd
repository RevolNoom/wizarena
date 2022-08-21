extends Path2D

#TODO: There's add new spell, there should be remove spell

func _ready():
	$SpellSlot0.RefersTo($SpellSlot0/Spell)

func AddNewSpell(newSpell: Spell):
	var emptyslot = FindEmptySlot()
	if emptyslot == null:
		print("Can't find empty slot")
		return
		
	var ss = preload("res://Functionality/Global/SpellSlot.tscn")
	var newSS = ss.instance()
		
	emptyslot.add_child(newSS)
	newSS.RefersTo(newSpell)
	
	
	
func FindEmptySlot():
	for i in range(0, 8):
		var slot = get_node("SpellSlot"+str(i))
		if slot.get_child_count() == 0:
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
	for slot in get_children():
		slot._on_mouse_unclick()
	
func DisableUntilAstralTableDone():
	CloseWheel()
	set_process_unhandled_input(false)
	
# Handle to call from AstralTable
func Reenable():
	set_process_unhandled_input(true)
