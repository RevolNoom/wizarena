extends Control
signal cast_spell
	
	
func Share(hpBar, manaBar, focusBar):
	hpBar.share($Top/Attributes/Health)
	manaBar.share($Top/Attributes/Mana)
	focusBar.share($Top/Attributes/Focus)


func _on_SpellSlot_pressed():
	emit_signal("cast_spell")
