extends Dummy

signal exhausted

func _ready():
	$CanvasLayer/GUI.ConnectTo(self)
	var ignore_err = $Focus.connect("empty", $CanvasLayer/AstralTable, "StopWeaving")
	ignore_err = $Mana.connect("empty", $CanvasLayer/AstralTable, "StopWeaving")
	ignore_err = $CanvasLayer/SpellWheel.connect("spell_chosen", self, "_on_SpellWheel_spell_chosen")
	ignore_err = $CanvasLayer/AstralTable.connect("end_weave", self, "_on_AstralTable_end_weave")
	ignore_err = $CanvasLayer/AstralTable.connect("spell_changed", $CanvasLayer/GUI, "_on_AstralTable_spell_changed")
	ignore_err = $CanvasLayer/GUI.connect("cast_spell", self, "CastSpell")

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
		
	set_global_rotation((get_global_mouse_position() - global_position).angle())
		
	var dontcare = move_and_slide(velocity)	
	
func ExhaustedFromSpellWeaving():
	emit_signal("exhausted")
	
	
func _on_AstralTable_end_weave(spell):
	spell.StopSuckingResourceFrom(self)
	$CanvasLayer/SpellWheel.Reenable()
	
	
func _on_SpellWheel_spell_chosen(spell):
	if spell.SuckResourceFrom(self) == false:
		print("Not enough resource for spell")
		return
	$CanvasLayer/SpellWheel.DisableUntilAstralTableDone()
	$CanvasLayer/AstralTable.StartWeaving(spell)

	
	
# Called from GUI
func ConnectToGUI(hpBar, manaBar, focusBar):
	$Health.share(hpBar)
	$Mana.share(manaBar)
	$Focus.share(focusBar)	
