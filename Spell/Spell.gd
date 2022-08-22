# ObjectPool
# +) Manage Stars states
# +) Test spell complete conditions

extends Node

class_name Spell

func _ready():
	_activable = get_node(_activable_path)
	
	# Keep the references to children
	# But they won't show up in the scene
	_starList = $Star.get_children()
	for star in _starList:
		$Star.remove_child(star)
		star.Deactivate()
		star.SetMasterSpell(self)
	
func GetRandomizedStarList():
	for star in _starList:
		star.Reset()
	_starList.shuffle()
	return _starList
	

func ActivateStarsInputProcessing():
	for star in _starList:
		star.Activate()
		
func DeactivateStarsInputProcessing():
	for star in _starList:
		star.Deactivate()

func _on_StarTouched(_star):
	if IsCompleted():
		GlobalState.SpellWeavedSuccessfully(self)

func FailedByStarLock(_lockedStar):
	print("Spell failed: Mouse drawn over locked star.")
	
func IsCompleted():
	for star in _starList:
		if not star.IsTouched():
			return false
	return true

var _starList
export(StreamTexture) var _icon_texture

export(NodePath) var _activable_path
var _activable
	
export var _hp_cost = 0
export var _mana_cost = 0
export var _focus_per_sec = 0
