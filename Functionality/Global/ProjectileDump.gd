extends Node


func Add(projectile):
	projectile.z_index = 1
	add_child(projectile)
