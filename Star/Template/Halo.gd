extends Sprite

signal finished

export(float, 0, 1) var from
export(float, 0, 1) var to
export(float, 0, 60) var forth_time
export(float, 0, 60) var back_time
export(bool) var playing = false
export(bool) var oneshot = false
var tween


func _ready():
	modulate = Color(1, 1, 1, from)
	if playing:
		Play()


func Play():
	tween = create_tween()
	tween.connect("finished", self, "_on_tween_finished")
	tween.tween_property(self, "modulate", Color(1, 1, 1, to), forth_time).set_trans(Tween.TRANS_SINE)
	tween.tween_property(self, "modulate", Color(1, 1, 1, from), back_time).set_trans(Tween.TRANS_SINE)
	
	tween.set_loops(oneshot)
	
	tween.play()
	

func Stop():
	if tween.is_valid():
		tween.kill()


func _on_tween_finished():
	playing=false
	emit_signal("finished")
