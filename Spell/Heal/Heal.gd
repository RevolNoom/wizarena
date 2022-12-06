extends Spell
# Choose a player target in range to heal.

# TODO: Scale healing amount with power
# Let player choose who to heal
func Activate(caster):
	caster.rpc("CastSpell", "res://Spell/Heal/Heal.tscn", [caster.get_path(), caster.get_path(), 50])

# customSpellArguments:
# @0: Caster's SceneTree Path
# @1: Receiver's SceneTree Path
# @2: Healing amount
func Instantiate(customSpellArguments: Array):
	var caster = get_node(customSpellArguments[0])
	var receiver = get_node(customSpellArguments[1])
	_totalHeal = customSpellArguments[2]
	# TODO: Heal every sec

export var heal_interval = 1.0
export var heal_duration = 5.0
var _totalHeal
