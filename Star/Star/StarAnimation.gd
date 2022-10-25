extends Sprite

export(float, 0, 1) var from
export(float, 0, 1) var to
export(float, 0, 60) var forth_time
export(float, 0, 60) var back_time

func _ready():
	tween = create_tween()
	$Halo.modulate = Color(1, 1, 1, from)
	tween.tween_property($Halo, "modulate", Color(1, 1, 1, to), forth_time).set_trans(Tween.TRANS_SINE)
	tween.tween_property($Halo, "modulate", Color(1, 1, 1, from), back_time).set_trans(Tween.TRANS_SINE)
	tween.set_loops()

func _on_StarAnimation_visibility_changed():
	if visible:
		tween.play()
	else:
		tween.pause()

var tween
