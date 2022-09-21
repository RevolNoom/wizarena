extends Spell

# Called when the node enters the scene tree for the first time.
func Activate(caster):
	var rockspawntscn = preload("res://Spell/Seisme/RockSpawn.tscn")
	var rs = rockspawntscn.instance()
	GlobalSettings.get_node("ProjectileDump").Add(rs)
	rs.set_global_rotation(caster.global_rotation)
	rs.set_global_position(caster.global_position + Vector2(100, 0).rotated(caster.global_rotation))
	
	rs.Spawn()
	
	pass
