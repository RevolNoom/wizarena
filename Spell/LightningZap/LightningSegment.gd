extends Area2D

class_name LightningSegment

export var delay_time = 0.01
export var damage = 10
var _branch = []
var _time_until_child_zap = 0
var _zappedBranch = 0

signal zapped(self_segment)


# Called when the node enters the scene tree for the first time.
func _ready():
	set_process(false)
	for child in get_children():
		# WARNING: I'd prefer Area2D to be LightningSegment
		# but this has to do for now
		if child is Area2D:
			_branch.push_back(child)
			child.connect("zapped", self, "_on_child_zapped")


func Zap():
	TweenVisibility()
	
	_zappedBranch = 0
	if get_overlapping_bodies().size() == 0:
		_time_until_child_zap = delay_time
		set_process(true)
	else:
		var obj = get_overlapping_bodies().front() 
		if obj is Dummy:
			obj.get_node("Health").TakeDamage(damage)
			
	if _branch.size() == 0:
		set_process(false)
		emit_signal("zapped", self)


func TweenVisibility():
	$Sprite.visible = true
	$Sprite.self_modulate.a = 1.0
	var tween = create_tween().tween_property($Sprite, "self_modulate:a", 0.0, 1.0)
	tween.connect("finished", self, "_on_Tween_finished")


func _process(delta):
	_time_until_child_zap -= delta
	if _time_until_child_zap <= 0:
		set_process(false)
		for branch in _branch:
			branch.Zap()
	

func _on_child_zapped(_segment):
	_zappedBranch += 1
	if _zappedBranch == _branch.size():
		emit_signal("zapped", self)
			

func _on_Tween_finished():
	$Sprite.visible = false
