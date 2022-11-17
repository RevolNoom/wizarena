extends Node2D

signal end_game



func _on_MainMenuButton_pressed():
	BackToLobby()


func _on_player_die(player):
	_playerLeft.erase(player)
	if player.name ==  str(get_tree().get_network_unique_id()):
		ShowResultScreen("You Lose")
	elif _playerLeft.size() == 1 and _playerLeft[0].name == str(get_tree().get_network_unique_id()):
		ShowResultScreen("You Win")
		rpc("EndMatch")
		

func Initialize():
	visible = true
	var map = $Map.get_child(0)
	map.LoadPlayers()
	_playerLeft = map.get_players()
	for player in map.get_players():
		player.connect("die", self, "_on_player_die")


func BackToLobby():
	Menu.GetLobby().GetRoom().SetStatusOf(get_tree().get_network_unique_id(), "WATCHING")
	Menu.visible = true
	visible = false
	$CanvasLayer.visible = false


func ShowResultScreen(resultLine):
	$CanvasLayer/CenterContainer/VBox/GameResult.text = resultLine
	$CanvasLayer.visible = true
	

remotesync func EndMatch():
	$CanvasLayer/CenterContainer/VBox/ToLobbyNotice.Start()
	emit_signal("end_game")
	
	
var _playerLeft
