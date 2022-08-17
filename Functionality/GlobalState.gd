extends Node

signal spell_changed(spell)

var _player
#var _spellSlot Petition to kill this off

func SetSpell(spell):
	#_spellSlot = spell
	emit_signal("spell_changed", spell)
