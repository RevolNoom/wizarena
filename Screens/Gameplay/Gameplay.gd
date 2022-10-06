extends Node2D

func _ready():
	var map = $Map.get_children()[0]
	map.LoadPlayers()
	_playerCount = map.get_players().size()
	for player in map.get_players():
		player.connect("die", self, "_on_player_die")


func _on_MainMenuButton_pressed():
	get_tree().change_scene("res://Screens/Menu/Menu.tscn")


func _on_player_die(player):
	if player.name == str(get_tree().get_network_unique_id()):
		ShowResultScreen("You Lose")
		return
		
	_playerCount -= 1
	if _playerCount == 1:
		ShowResultScreen("You Win")
	


func ShowResultScreen(resultLine):
	$CanvasLayer/CenterContainer/VBoxContainer/GameResult.text = resultLine
	$CanvasLayer.visible = true

var _playerCount
