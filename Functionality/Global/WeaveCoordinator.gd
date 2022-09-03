extends Node

# For now, only GUI spell key connects to this signal
signal spell_changed(spell)

var _player

func _ready():
	seed(OS.get_system_time_msecs())
	
# Injector for Player class.
# Call this on Player initialization
func SetPlayer(player):
	if _player != null:
		_player.disconnect("exhausted", self, "StopWeavingProcedure")
	if player != null:
		GetGUI().ConnectTo(player)
		player.connect("exhausted", self, "StopWeavingProcedure")
	_player = player
	
func GetPlayer():
	return _player

func StartWeavingProcedure(spell):
	if spell.SuckResourceFrom(_player) == false:
		print("Not enough resource for spell")
		return
	
	_weavingSpell = spell
		
	GetSpellWheel().DisableUntilAstralTableDone()
	GetAstralTable().PrepareSpell(spell)
	
	
func StopWeavingProcedure():
	_weavingSpell.StopSuckingResourceFrom(_player)
	
	GetAstralTable().CleanUp()
	
	_weavingSpell = null
	
	GetSpellWheel().Reenable()
	
	
func SpellWeavedSuccessfully(spell):
	StopWeavingProcedure()
	emit_signal("spell_changed", spell)
	

func GetAstralTable():
	return $CanvasLayer/AstralTable
	
func GetSpellWheel():
	return $CanvasLayer/SpellWheel

func GetGUI():
	return $CanvasLayer/GUI
	
func GetProjectileDump():
	return $ProjectileDump
	
var _weavingSpell
