extends RigidBody2D

export var damage = 10

func _enter_tree():
	SetDetectionMode()
	

# In this mode, the rock only detects players that it'll 
# deal damage when it Erupt()
func SetDetectionMode():
	visible = false
	set_deferred("collision_layer", 0) #GlobalSettings.PhysicLayer.OBJECT)
	set_deferred("collision_mask", GlobalSettings.PhysicLayer.PLAYER) # | GlobalSettings.PhysicLayer.OBJECT | GlobalSettings.PhysicLayer.PROJECTILE)
	
func Erupt():
	for player in get_colliding_bodies():
		if player is Dummy:
			DealDamage(player)
			
	set_deferred("collision_layer", GlobalSettings.PhysicLayer.OBJECT)
	set_deferred("collision_mask", GlobalSettings.PhysicLayer.PLAYER | GlobalSettings.PhysicLayer.OBJECT | GlobalSettings.PhysicLayer.PROJECTILE)
	visible = true
	
func DealDamage(player):
	player.get_node("Health").TakeDamage(damage)
