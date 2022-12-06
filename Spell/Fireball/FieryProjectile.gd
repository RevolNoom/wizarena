extends RigidBody2D

func _on_Fireball_body_entered(body):
	if body is Dummy:
		body.TakeDamagePhysical(damage)
	BecomeDisabled()
	queue_free()

func BecomeDisabled():
	visible = false
	set_deferred("collision_mask", 0)
	set_deferred("collision_layer", 0)

export var damage = 0
export var velocity = 0
