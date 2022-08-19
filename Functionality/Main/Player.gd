extends KinematicBody2D

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _process(_delta):
	var velocity = Vector2()
	if Input.is_action_pressed("ui_left"):
		velocity.x = -_speed
	if Input.is_action_pressed("ui_right"):
		velocity.x = _speed
	if Input.is_action_pressed("ui_up"):
		velocity.y = -_speed
	if Input.is_action_pressed("ui_down"):
		velocity.y = _speed
		
	var dontcare = move_and_slide(velocity)
	
	
	
		
		
export var _health = 0
export var _focus = 0
export var _speed = 0

