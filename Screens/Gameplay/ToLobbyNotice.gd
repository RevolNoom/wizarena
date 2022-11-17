extends CenterContainer


signal play_time_is_over


func _ready():
	set_process(false)
	

func Start():
	visible = true
	_timer = get_tree().create_timer(Start_Time)
	_timer.connect("timeout", self, "_on_timer_timeout")
	$Bar.max_value = Start_Time
	set_process(true)


func _process(_delta):
	$Second.text = str(ceil(_timer.time_left))
	$Bar.value = _timer.time_left


func _on_timer_timeout():
	DisableTimer()
	emit_signal("play_time_is_over")


func _on_MainMenuButton_pressed():
	if _timer != null:
		_timer.disconnect("timeout", self, "_on_timer_timeout")
		_timer = null
		DisableTimer()
		

func DisableTimer():
	visible = false
	set_process(false)


var _timer = null
export var Start_Time = 10
