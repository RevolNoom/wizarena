extends RigidBody2D

export var damage = 10

# In this mode, the rock only detects players that it'll 
# deal damage when it Erupt()
func SetDetectionMode():
	visible = false
	set_deferred("collision_layer", GlobalSettings.PhysicLayer.PLAYER)
	
func Erupt():
	for player in get_colliding_bodies():
		if player is Dummy:
			DealDamage(player)
			
	visible = true
	set_deferred("collision_layer", GlobalSettings.PhysicLayer.PLAYER + GlobalSettings.PhysicLayer.OBJECT)
	
	
func DealDamage(player):
	player.get_node("Health").TakeDamage(damage)
