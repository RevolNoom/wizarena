extends RigidBody2D

# In Preying mode, the rock only detects players that it'll 
# deal damage when it Erupt()
func SetPreyingMode():
	set_deferred("collision_layer", 0)
	collision_layer = 1
	pass
	
func Erupt():
	pass
