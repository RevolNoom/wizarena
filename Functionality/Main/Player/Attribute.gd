extends ProgressBar

signal full() #(player)
signal empty()

signal healed(amount)
signal damaged(amount)

export var _regen= 0.0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

func _process(delta):	
	value += _regen * delta
	
	# Only signal once when value touches max or min,
	# not signalling every frame
	TestSignal()
		
		
func TakeDamage(amount):
	
	amount = clamp(amount, 0, value)
	value -= amount
	
	if amount > 0:
		emit_signal("damaged", amount)
		TestSignal()
		
		
func TakeDamageOverTime(amount):
	_regen -= amount
	
func Heal(amount):
	amount = clamp(amount, 0, max_value - value)
	value += amount
	
	if amount > 0:
		emit_signal("healed", amount)
		TestSignal()
		
		
func HealOverTime(amount):
	_regen += amount
		
		
func TestSignal():
	if value >= max_value:
		# TODO: Disable _process when full
		
		emit_signal("full")
	elif value <= 0:
		emit_signal("empty")
	
