extends Star


func _on_LockRadius_area_entered(area):
	if area != self and area is Star:
		area.BeLockedBy(self)
