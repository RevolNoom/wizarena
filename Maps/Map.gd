extends Node2D

class_name Map

func LoadPlayers():
	_players.clear()
	var spawnpoint = 1
	var players = Network._player.keys()
	players.sort()
	for playerID in players:
		var player
		if playerID == get_tree().get_network_unique_id():
			player = preload("res://Player/Player.tscn").instance()
		else:
			player = preload("res://Player/Dummy.tscn").instance()
			
		player.name = str(playerID)
		player.set_network_master(playerID)
		
		_players.append(player)
		$SpawnPoint.get_node(str(spawnpoint)).add_child(player)
		spawnpoint += 1


func get_players():
	return _players
	
	
var _players = []
