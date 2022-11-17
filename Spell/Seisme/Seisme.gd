extends Spell

func Activate(caster):
	caster.rpc("CastSpell", "res://Spell/Seisme/Seisme.tscn", [caster.get_path(), caster.global_position, caster.global_rotation])
	
# customSpellArguments:
# @0: Caster's SceneTree Path
# @1: Global Position
# @2: Global Rotation
func Instantiate(customSpellArguments: Array):
	var caster = get_node(customSpellArguments[0])
	var gpos = customSpellArguments[1]
	var grot = customSpellArguments[2]
	
	var rockspawntscn = preload("res://Spell/Seisme/RockSpawn.tscn")
	var rs = rockspawntscn.instance()
	Gameplay.get_node("Dump").Add(rs)
	
	rs.set_global_rotation(grot)
	rs.set_global_position(gpos + Vector2(50, 0).rotated(grot))
	
	rs.Spawn()
