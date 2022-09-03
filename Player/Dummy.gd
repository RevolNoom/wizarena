extends KinematicBody2D

class_name Dummy

# Called when the node enters the scene tree for the first time.
func _ready():
	var dontcare = $Focus.connect("empty", self, "ExhaustedFromSpellWeaving")
	dontcare = $Mana.connect("empty", self, "ExhaustedFromSpellWeaving")
	dontcare = $Health.connect("empty", self, "Die")


func Die():
	visible = false
	set_deferred("collision_layer", 0)
	set_deferred("collision_mask", 0)
	queue_free()	
	
	
# Subclass sandbox
func Move():
	pass


func CastSpell():
	pass
	
	
# This one will be used when
# I add multiplayer mode to game
func DoAction(_action):
	pass
	
var _currentWeavingSpell
