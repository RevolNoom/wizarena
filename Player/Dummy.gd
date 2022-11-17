extends KinematicBody2D

class_name Dummy

signal die(dummy)

# Called when the node enters the scene tree for the first time.
func _ready():
	var dontcare = $Health.connect("empty", self, "Die", [], CONNECT_ONESHOT)


func IsAlive():
	return $Health.value == 0


func Die():
	visible = false
	set_deferred("collision_layer", 0)
	set_deferred("collision_mask", 0)
	emit_signal("die", self)
	
	
# Subclass sandbox
remotesync func UpdatePosture(newGPosition, newGRotation):
	global_position = newGPosition
	global_rotation = newGRotation


remotesync func CastSpell(spellname, customSpellArguments: Array):
	print("Casting spell")
	var spell = load(spellname).instance()
	Gameplay.get_node("Dump").Add(spell)
	spell.Instantiate(customSpellArguments)
