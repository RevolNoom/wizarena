extends RigidBody2D

func _on_Fireball_body_entered(body):
	if body.get_class() == "Player":
		#TODO: Is this "if" working?
		pass
	BecomeDisabled()
	queue_free()

func BecomeDisabled():
	self.visible = false
	set_deferred("collision_mask", 0)
	set_deferred("collision_layer", 0)
	
