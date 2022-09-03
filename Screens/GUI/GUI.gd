extends Control

func _ready():
	WeaveCoordinator.SetGUI(self)
	
func ConnectTo(player):
	player.ConnectToGUI($Top/Attributes/Health, $Top/Attributes/Mana, $Top/Attributes/Focus)
	
