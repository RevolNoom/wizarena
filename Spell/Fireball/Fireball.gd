extends Spell

func Activate(caster):
	caster.rpc("CastSpell", "res://Spell/Fireball/Fireball.tscn", [caster.get_path(), caster.global_position, caster.global_rotation])

# customSpellArguments:
# @0: Caster's SceneTree Path
# @1: Global Position
# @2: Global Rotation
func Instantiate(customSpellArguments: Array):
	var caster = get_node(customSpellArguments[0])
	var gpos = customSpellArguments[1]
	var grot = customSpellArguments[2]
	
	var fireball = preload("res://Spell/Fireball/FieryProjectile.tscn")
	var fb = fireball.instance()
	GlobalSettings.get_node("ProjectileDump").Add(fb)
	fb.set_global_position(gpos)
	fb.set_global_rotation(grot)
	fb.add_collision_exception_with(caster)
	
	fb.damage = 50

	fb.linear_velocity = Vector2(fb.velocity, 0).rotated(grot)
