extends Dummy

func _ready():
	var ignore_err = GetAttribute("Focus").connect("empty", self, "ExhaustedFromSpellWeaving")
	ignore_err = GetAttribute("Mana").connect("empty", self, "ExhaustedFromSpellWeaving")
	ignore_err = $CanvasLayer/SpellWheel.connect("spell_chosen", self, "_on_SpellWheel_spell_chosen")
	ignore_err = $CanvasLayer/AstralTable.connect("done", self, "_on_AstralTable_done")
	ignore_err = connect("die", self, "_on_Player_die")




func _process(_delta):
	var velocity = Vector2()
	var player_speed = GetAttribute("Speed").value
	
	if Input.is_action_pressed("ui_left"):
		velocity.x = - player_speed
	if Input.is_action_pressed("ui_right"):
		velocity.x = player_speed
	if Input.is_action_pressed("ui_up"):
		velocity.y = - player_speed
	if Input.is_action_pressed("ui_down"):
		velocity.y = player_speed
		
	var dontcare = move_and_slide(velocity, Vector2(0, 0), false, 1, 0.1, false)
	
	rpc("UpdatePosture", global_position, (get_global_mouse_position() - global_position).angle())


func ExhaustedFromSpellWeaving():
	_StopSustainWeave()
	_spellReceipt = null
	$CanvasLayer/AstralTable.StopWeaving()
	$CanvasLayer/SpellWheel.Enable()
	


func _on_Player_die(_self):
	# TODO: Stop Player's regen?
	$CanvasLayer/AstralTable.StopWeaving()
	$CanvasLayer/SpellWheel.Disable()
	RemoveProcessors()


# Handle to be called from HUD when player press spell casting key
func _on_HUD_cast_spell():
	if _spellInUse != null:
		_spellInUse.Activate(self)
		_spellInUse = null


func AddProcessor(proc):
	$SpellProcessor.add_child(proc)


func _on_AstralTable_done(wovenSpell):
	#print("end weave")
	#_spellInWeave.StopSuckingResourceFrom(self)
	_spellInUse = wovenSpell
	ExhaustedFromSpellWeaving()


func RemoveProcessors():
	for proc in $SpellProcessor.get_children():
		$SpellProcessor.remove_child(proc)
		proc.queue_free()


func _on_SpellWheel_spell_chosen(spell):
	_spellReceipt = spell.DoCalculateInitialCost(self) 
	if _spellReceipt[0] == false:
		print("Not enough resource for spell")
		return
		
	RemoveProcessors() # from previous Spell
	_CostSpellResource()
	$CanvasLayer/SpellWheel.Disable()
	$CanvasLayer/SpellWheel.PopSpellOffWheel(spell)
	$CanvasLayer/AstralTable.StartWeaving(spell)


func _CostSpellResource():
	for rss in _spellReceipt[1]:
		var attr_name = rss[0]
		var amount = rss[1]
		var weave_sustain = rss[2]
		var player_attr = GetAttribute(attr_name)
		player_attr.Reduce(amount)
		player_attr.ReduceRegen(weave_sustain)


func _StopSustainWeave():
	for rss in _spellReceipt[1]:
		GetAttribute(rss[0]).AddRegen(rss[2])


var _spellReceipt


var _spellInUse
var _spellInWeave
