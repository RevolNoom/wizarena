extends TextureButton

signal cast_spell(spell)

var _spell
export var _keyBinding = ""


# Called when the node enters the scene tree for the first time.
func _ready():
	var err = connect("pressed", self, "_on_SpellKey_pressed")
	# TODO: Connect some signal from Player to this button
	#err = WeaveCoordinator.connect("spell_changed", self, "change_spell")

func _on_SpellKey_pressed():
	if _spell == null:
		return
	
	var spell = _spell
	_spell = null
	emit_signal("cast_spell", spell)
		
	
func _unhandled_key_input(event):
	if event.pressed and event.scancode == ord(_keyBinding):
		_on_SpellKey_pressed()
		get_tree().set_input_as_handled()

	
	
