extends Node

signal spell_changed(spell)

var _player

func _ready():
	seed(OS.get_system_time_msecs())
	
# Injector for Player class.
# Call this on Player initialization
func SetPlayer(player):
	_player = player
	if _player != null:
		GetGUI().ConnectTo(_player)
	
func GetPlayer():
	return _player

func StartWeavingProcedure(spell):
	if _player.PaySpellPrice(spell) == false:
		print("Not enough resource for spell")
		return
		
	GetSpellWheel().DisableUntilAstralTableDone()
	GetAstralTable().PrepareSpell(spell)
	
	
func StopWeavingProcedure():
	GetAstralTable().CleanUp()
	GetSpellWheel().Reenable()
	_player.StopPayingSpell()
	
	
func SpellWeavedSuccessfully(spell):
	StopWeavingProcedure()
	emit_signal("spell_changed", spell)
	

func GetAstralTable():
	return $CanvasLayer/AstralTable
	
func GetSpellWheel():
	return $CanvasLayer/SpellWheel

func GetGUI():
	return $CanvasLayer/GUI
