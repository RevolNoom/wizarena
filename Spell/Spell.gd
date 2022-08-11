extends Node

func GetRandomizedStarList():
	return $Star.get_children().shuffle()

func SetAstralTable(masterAstralTable):
	_masterTable = masterAstralTable

func StartWeaving():
	for star in $Star.get_children():
		star.Activate()
		
func EndWeaving():
	for star in $Star.get_children():
		star.Deactivate()
	

func _on_MouseOffTable():
	pass
	
func _on_MouseUnpress():
	pass

func Failed():
	pass
	
func Completed():
	pass

# The astral table to communicate with
var _masterTable
