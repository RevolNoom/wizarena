extends Node

# Return an InputInspector if this spell needs extra input
# Else, cast the spell and return null
func Activate(caster):
	var fireball = preload("res://Spell/Fireball/Fireball.tscn")
	var fb = fireball.instance()
	WeaveCoordinator.GetProjectileDump().Add(fb)
	fb.set_global_position(caster.get_global_position())
	fb.set_global_rotation(caster.get_global_rotation())
	fb.add_collision_exception_with(caster)
	
	fb.damage = 50

	var impulse = Vector2(300, 0).rotated(fb.get_global_rotation())
	fb.apply_central_impulse(impulse)
