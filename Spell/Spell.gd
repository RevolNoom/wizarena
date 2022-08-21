# ObjectPool
# +) Manage Stars
# +) Test spell weaving condition

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
	# TODO: Randomize dependencies
	return _starList.shuffle()
	
# Called by AstralTable on Preparation:
func DoPreparation():
	pass


func StartWeaving():
	for star in _starList:
		star.Activate()
		
func EndWeaving():
	for star in _starList:
		star.Deactivate()
	
func GetStarList():
	return _starList
	
func _on_MouseOffTable():
	print("Spell failed: Mouse goes off table before all stars are drawn")
	
func _on_MouseUnpress():
	print("Spell failed: Mouse unpress before all stars are drawn.")

func _on_StarTouched(_star):
	if IsCompleted():
		EndWeaving()
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
