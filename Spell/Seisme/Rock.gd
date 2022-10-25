extends RigidBody2D

export var damage = 10

func _enter_tree():
	SetDetectionMode()
	

# In this mode, the rock only detects players that it'll 
# deal damage when it Erupt()
func SetDetectionMode():
	visible = false
	set_deferred("collision_layer", 0)
	set_deferred("collision_mask", ProjectSettings.get_setting("physics/2d/layer")["player"])
	
	
func Erupt():
	for player in get_colliding_bodies():
		if player is Dummy:
			DealDamage(player)
			
	set_deferred("collision_layer", ProjectSettings.get_setting("physics/2d/layer")["object"])
	set_deferred("collision_mask", ProjectSettings.get_setting("physics/2d/layer")["player"] | 
									ProjectSettings.get_setting("physics/2d/layer")["object"]|
									ProjectSettings.get_setting("physics/2d/layer")["projectile"])
	visible = true
	
func DealDamage(player):
	player.get_node("Health").TakeDamage(damage)
