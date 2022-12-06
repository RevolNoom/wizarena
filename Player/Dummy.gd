extends KinematicBody2D

class_name Dummy

signal die(dummy)

# Called when the node enters the scene tree for the first time.
func _ready():
	var dontcare = GetAttribute("Health").connect("empty", self, "Die", [], CONNECT_ONESHOT)


func GetAttribute(name):
	return $Attribute.get_node(name)


# DAMAGING FUNCTIONS
# Deal damage to Health, inversely proportional to Armor
func TakeDamagePhysical(amount, piercing := 0):
	_TakeDamage("Health", amount, GetAttribute("Armor").value, piercing)


# Deal damage to Health, inversely proportional to Repellence
func TakeDamageMagical(amount, piercing := 0):
	_TakeDamage("Health", amount, GetAttribute("Repellence").value, piercing)
	

# Deal damage to Mana, inversely proportional to Will
func TakeDamageMental(amount, piercing := 0):
	_TakeDamage("Mana", amount, GetAttribute("Will").value, piercing)


func _TakeDamage(attribute_name, amount, defense_value, piercing):
	GetAttribute(attribute_name).Reduce(amount * (100 + piercing) / (100 + defense_value))


func Heal(amount):
	GetAttribute("Health").Add(amount)


# Take negative Effect with effectiveness inversely proportion to Resilience
#func TakeNegativeEffect():
	#pass


# Deal damage to Stamina, inversely proportional to ???
#func TakeDamageStamina(amount):
#	pass


# MISC

func IsAlive():
	return GetAttribute("Health").value == 0


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
