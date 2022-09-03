extends TextureButton

var _spell
export var _keyBinding = ""


# Called when the node enters the scene tree for the first time.
func _ready():
	var err = connect("pressed", self, "_on_SpellKey_pressed")
	err = WeaveCoordinator.connect("spell_changed", self, "change_spell")

func _on_SpellKey_pressed():
	if _spell == null:
		return
		
	# TODO: Check InputInspector return
	_spell._activable.Activate(WeaveCoordinator._player)
	change_spell(null)

func _unhandled_key_input(event):
	if event.pressed and event.scancode == ord(_keyBinding):
		_on_SpellKey_pressed()

func change_spell(spell):
	_spell = spell
	
	
