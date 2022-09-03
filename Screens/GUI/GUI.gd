extends Control

func ConnectTo(player):
	player.ConnectToGUI($Top/Attributes/Health, $Top/Attributes/Mana, $Top/Attributes/Focus)
	
