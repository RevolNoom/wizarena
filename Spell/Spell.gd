# ObjectPool
# +) Manage Stars states
# +) Test spell complete conditions

extends Node

class_name Spell

func _ready():
	_activable = get_node(_activable_path)
	
	# Keep the references to children
	# But they won't show up in the scene
	StarList = $Star.get_children()
	for star in StarList:
		$Star.remove_child(star)
		star.Deactivate()
		
	for cost in [$Health, $Mana, $Focus]:
		cost.set_process(false)


# Try costing the player's resource: Hp, mana, focus, speed?
# Return true if the spell costed the player successfully
# False otherwise
func SuckResourceFrom(player):
	
	# Pre-pay check
	if player.get_node("Health").value < $Health.value or\
	player.get_node("Mana").value < $Mana.value or\
	player.get_node("Focus").value < $Focus.value:
		return false
		
	for attribute in ["Health", "Mana", "Focus"]:
		player.get_node(attribute).TakeDamage(get_node(attribute).value)
		player.get_node(attribute).TakeDamageOverTime(get_node(attribute).regen)
	
	return true

	
# TODO: Test player hasn't been freed
# Return the spell cost to the player
func StopSuckingResourceFrom(player):
	for attribute in ["Health", "Mana", "Focus"]:
		#player.get_node(attribute).Heal(get_node(attribute).value)
		player.get_node(attribute).HealOverTime(get_node(attribute).regen)

var StarList
export(StreamTexture) var _icon_texture

export(NodePath) var _activable_path
var _activable
