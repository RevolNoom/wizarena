extends Area2D

class_name Spell

func _ready():
	# Keep the references to children
	# But they won't show up in the scene
	StarList = $Star.get_children()
	for star in StarList:
		$Star.remove_child(star)


# OVERRIDE ME
# TODO: Called after player done weaving it
# Called when Player wants to get more input to prepare spell
func Activate(_caster):
	pass


# OVERRIDE ME
# Called from Dummy when syncing spell casts
func Instantiate(_customSpellArguments: Array):
	pass


# Return an array of 2 values:
# [0]: true if the player has enough resource to cast spell
#		false otherwise
# [1]: An array of array. Each element of array is of the form:
#		[1][i] = ["Mana", 12, 10]
#		That means it takes 12 mana to cast the spell, 10 mana to sustain spell weavement
func DoCalculateInitialCost(player):
	var receipt = [true, []]
	receipt[1].resize($Cost.get_child_count())
	for i in range(0, $Cost.get_child_count()):
		var cost = $Cost.get_child(i)
		var attr_name = cost.name
		var pattribute = player.GetAttribute(attr_name)
		
		var total_cost = cost.base_value\
						+ pattribute.value * cost.current_percentage\
						+ pattribute.max_value * cost.max_percentage\
						+ (pattribute.max_value-pattribute.value) * cost.missing_percentage
		
		
		receipt[0] = (cost.allow_overprice or pattribute.value >= total_cost)\
					and pattribute.value > cost.min_required_value\
					and pattribute.CurrentPercentage() >= cost.min_required_percentage
					#and pattribute.CurrentPercentage() <= cost.max_required_percentage\
#					and pattribute.value < cost.max_required_value\
					
		receipt[1][i] = [attr_name, total_cost, cost.sustain_weave]
		
	return receipt


func get_texture():
	return $Icon.texture


var StarList
export(String, MULTILINE) var description


func _on_Icon_mouse_entered():
	emit_signal("mouse_entered")

func _on_Icon_mouse_exited():
	emit_signal("mouse_exited")
