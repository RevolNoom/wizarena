extends KinematicBody2D

# Called when the node enters the scene tree for the first time.
func _ready():
	GlobalState.SetPlayer(self)
	var dontcare = $Focus.connect("empty", self, "ExhaustedFromSpellWeaving")
	dontcare = $Mana.connect("empty", self, "ExhaustedFromSpellWeaving")
	# TODO: Connect empty from hp to Die()

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
		
	var dontcare = move_and_slide(velocity)
	
# Try to make the player pay for the spell price
# Return true if the price is paid successfully
# false otherwise
func PaySpellPrice(spell):
	_currentWeavingSpell = spell
	
	if $Health.value > spell._hp_cost and \
	$Mana.value > spell._mana_cost:
		$Health.TakeDamage(spell._hp_cost)
		$Mana.TakeDamage(spell._mana_cost)
		$Focus.TakeDamageOverTime(spell._focus_per_sec)
		return true
	return false
	
# Called from GlobalState when player stops weaving
func StopPayingSpell():
	if _currentWeavingSpell == null:
		return
	
	$Focus.HealOverTime(_currentWeavingSpell._focus_per_sec)
	_currentWeavingSpell = null
	
# Called from GlobalState
func ConnectToGUI(hpBar, manaBar, focusBar):
	$Health.share(hpBar)
	$Mana.share(manaBar)
	$Focus.share(focusBar)
	
func ExhaustedFromSpellWeaving():
	if _currentWeavingSpell != null:
		GlobalState.StopWeavingProcedure()
	print("Exhausted")
	
var _currentWeavingSpell
