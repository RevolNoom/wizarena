extends Control
signal cast_spell(spell)
	
func ConnectTo(player):
	player.ConnectToGUI($Top/Attributes/Health, $Top/Attributes/Mana, $Top/Attributes/Focus)
	$"Bottom/SpellSlot/1".connect("cast_spell", self, "NotifyPlayerOnSpellCast")


func _on_AstralTable_spell_changed(spell):
	$"Bottom/SpellSlot/1"._spell = spell
	print("Changed spell")


func NotifyPlayerOnSpellCast(spell):
	emit_signal("cast_spell", spell)
