extends Area2D

class_name Spell

func _ready():
	# Keep the references to children
	# But they won't show up in the scene
	StarList = $Star.get_children()
	for star in StarList:
		$Star.remove_child(star)
		
	for cost in [$Health, $Mana, $Focus]:
		cost.set_process(false)

# OVERRIDE ME
# Called when Player wants to get more input to prepare spell
func Activate(_caster):
	pass
	
	
# OVERRIDE ME
# Called from Dummy when syncing spell casts
func Instantiate(_customSpellArguments: Array):
	pass
	
	
func get_activable():
	return $Activable


func CheckRequirement(player):
	if player.get_node("Health").value < $Health.value or\
	player.get_node("Mana").value < $Mana.value or\
	player.get_node("Focus").value < $Focus.value:
		return false
	return true
	

# Try costing the player's resource: Hp, mana, focus, speed?
# Return true if the spell costed the player successfully
# False otherwise
func SuckResourceFrom(player):
	for attribute in ["Health", "Mana", "Focus"]:
		player.get_node(attribute).TakeDamage(get_node(attribute).value)
		player.get_node(attribute).TakeDamageOverTime(get_node(attribute).regen)


# Return the spell cost to the player
func StopSuckingResourceFrom(player):
	for attribute in ["Health", "Mana", "Focus"]:
		#player.get_node(attribute).Heal(get_node(attribute).value)
		player.get_node(attribute).HealOverTime(get_node(attribute).regen)


func get_texture():
	return $Icon.texture


var StarList
export(String, MULTILINE) var description


func _on_Icon_mouse_entered():
	emit_signal("mouse_entered")

func _on_Icon_mouse_exited():
	emit_signal("mouse_exited")
