extends Control
signal cast_spell(spell)
	
func _ready():
	$Bottom/SpellSlot.connect("cast_spell", self, "NotifyPlayerOnSpellCast")
	
func Share(hpBar, manaBar, focusBar):
	hpBar.share($Top/Attributes/Health)
	manaBar.share($Top/Attributes/Mana)
	focusBar.share($Top/Attributes/Focus)
	
	
func _on_AstralTable_spell_changed(spell):
	$Bottom/SpellSlot._spell = spell
	print("Changed spell")


func NotifyPlayerOnSpellCast(spell):
	emit_signal("cast_spell", spell)
