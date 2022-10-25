extends Spell

export var impulse = 1000

func Activate(caster):
	caster.AddProcessor(preload("res://Spell/Telekinesis/ThrowObject.tscn").instance())

# TODO: Self cleanup?
# @0: Object Path
# @1: Direction
func Instantiate(customSpellArguments):
	var objPath = customSpellArguments[0]
	var direction = customSpellArguments[1]
	get_node(objPath).apply_central_impulse(direction*impulse)
