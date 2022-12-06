extends Spell


# Called when Player wants to get more input to prepare spell
func Activate(caster):
	caster.rpc("CastSpell", 
				"res://Spell/LightningZap/LightningZap.tscn", 
				[caster.get_path(), 
				caster.global_position, 
				caster.global_rotation,
				caster.GetAttribute("Power").value * 2])


# customSpellArguments:
# @0: Caster's SceneTree Path
# @1: Global Position
# @2: Global Rotation
# @3: Damage
func Instantiate(customSpellArguments: Array):
	var caster = get_node(customSpellArguments[0])
	var gpos = customSpellArguments[1]
	var grot = customSpellArguments[2]
	var damage = customSpellArguments[3]
	
	
	var lts = preload("res://Spell/LightningZap/LightningSpawn.tscn").instance()
	Gameplay.get_node("Dump").Add(lts)
	
	lts.set_global_rotation(grot)
	lts.set_global_position(gpos)
	
	lts.get_node("LightningSegment").damage = damage
	lts.Spawn()
