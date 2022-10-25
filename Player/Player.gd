extends Dummy

func _ready():
	$CanvasLayer/GUI.Share($Health, $Mana, $Focus)
	var ignore_err = $Focus.connect("empty", self, "ExhaustedFromSpellWeaving")
	ignore_err = $Mana.connect("empty", self, "ExhaustedFromSpellWeaving")
	ignore_err = $CanvasLayer/SpellWheel.connect("spell_chosen", self, "_on_SpellWheel_spell_chosen")
	ignore_err = $CanvasLayer/AstralTable.connect("done", self, "_on_AstralTable_done")
	ignore_err = $CanvasLayer/GUI.connect("cast_spell", self, "_on_GUI_cast_spell")
	ignore_err = connect("die", self, "_on_Player_die")


func _process(_delta):
	var velocity = Vector2()
	if Input.is_action_pressed("ui_left"):
		velocity.x = - $Speed.value
	if Input.is_action_pressed("ui_right"):
		velocity.x = $Speed.value
	if Input.is_action_pressed("ui_up"):
		velocity.y = - $Speed.value
	if Input.is_action_pressed("ui_down"):
		velocity.y = $Speed.value
		
	var dontcare = move_and_slide(velocity, Vector2(0, 0), false, 1, 0.1, false)
	
	rpc("UpdatePosture", global_position, (get_global_mouse_position() - global_position).angle())


func ExhaustedFromSpellWeaving():
	$CanvasLayer/AstralTable.StopWeaving()
	$CanvasLayer/SpellWheel.Enable()
	_spellInWeave.StopSuckingResourceFrom(self)
	_spellInWeave = null


func _on_Player_die(_self):
	$CanvasLayer/AstralTable.StopWeaving()
	$CanvasLayer/SpellWheel.Disable()


func _on_GUI_cast_spell():
	if _spellInUse != null:
		_spellInUse.Activate(self)
		_spellInUse = null


func AddProcessor(proc):
	$SpellProcessor.add_child(proc)


func _on_AstralTable_done():
	#print("end weave")
	_spellInWeave.StopSuckingResourceFrom(self)
	_spellInUse = _spellInWeave
	_spellInWeave = null
	$CanvasLayer/AstralTable.StopWeaving()
	$CanvasLayer/SpellWheel.Enable()


func RemoveProcessors():
	for proc in $SpellProcessor.get_children():
		$SpellProcessor.remove_child(proc)
		proc.queue_free()


func _on_SpellWheel_spell_chosen(spell):
	if spell.CheckRequirement(self) == false:
		print("Not enough resource for spell")
		return
		
	RemoveProcessors() # from previous Spell
	_spellInWeave = spell
	_spellInWeave.SuckResourceFrom(self)
	$CanvasLayer/SpellWheel.Disable()
	$CanvasLayer/SpellWheel.PopSpellOffWheel(_spellInWeave)
	$CanvasLayer/AstralTable.StartWeaving(_spellInWeave)


var _spellInWeave
var _spellInUse
