extends Node2D
# TODO: Pools LightningSpawn to save memory


func Spawn():
	$LightningSegment.Zap()


func _on_LightningSegment_zapped(self_segment):
	var timer = get_tree().create_timer(2)
	timer.connect("timeout", self, "_on_timer_timeout")
	
func _on_timer_timeout():
	queue_free()
