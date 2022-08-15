# ObjectPool
# +) Manage Stars
# +) Test spell weaving condition

extends Node

func _ready():
	# Keep the references to children
	# But they won't show up in the scene
	# This is better, to 
	_starList = $Star.get_children()
	for star in _starList:
		$Star.remove_child(star)
		star.Deactivate()
		star.SetMasterSpell(self)
	
func GetRandomizedStarList():
	# TODO: Randomize dependencies
	return _starList.shuffle()
	

func SetAstralTable(masterAstralTable):
	_masterTable = masterAstralTable

func StartWeaving():
	for star in _starList:
		star.Activate()
		
func EndWeaving():
	for star in _starList:
		star.Deactivate()
	_masterTable.CleanUp()
	_masterTable = null
	
func GetStarList():
	return _starList
	
func _on_MouseOffTable():
	print("Spell failed: Mouse goes off table before all stars are drawn")
	EndWeaving()
	
func _on_MouseUnpress():
	print("Spell failed: Mouse unpress before all stars are drawn.")
	EndWeaving()

func _on_StarTouched(_star):
	var completed = TestCompleteness()
	print("Completeness: " + str(completed))
	if completed:
		EndWeaving()

func FailedByStarLock(lockedStar):
	print("Spell failed: Mouse drawn over locked star.")
	
func TestCompleteness():
	for star in _starList:
		if not star.IsTouched():
			return false
	return true

# The astral table to communicate with
var _masterTable
var _starList
