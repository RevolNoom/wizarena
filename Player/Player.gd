extends Dummy

signal exhausted

func _ready():
	WeaveCoordinator.SetPlayer(self)

func _process(_delta):
	var velocity = Vector2()
	if Input.is_action_pressed("ui_left"):
		velocity.x = - $Speed.value
	if Input.is_action_pressed("ui_right"):
		velocity.x = $Speed.value
	if Input.is_action_pressed("ui_up"):
		velocity.y = - $Speed.value
	if Input.is_action_pressed("ui_down"):
		velocity.y = $Speed.value
		
	set_global_rotation((get_global_mouse_position() - global_position).angle())
		
	var dontcare = move_and_slide(velocity)	
	
func ExhaustedFromSpellWeaving():
	emit_signal("exhausted")
	

	
# Called from WeaveCoordinator
func ConnectToGUI(hpBar, manaBar, focusBar):
	$Health.share(hpBar)
	$Mana.share(manaBar)
	$Focus.share(focusBar)	
