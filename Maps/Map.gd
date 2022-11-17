extends Node2D

class_name Map

func LoadPlayers():
	#$RockSpawn.Spawn()
	_players.clear()
	var spawnpoint = 1
	var players = Menu.GetLobby().GetRoom().GetPlayerEntries()
	for entry in players:
		var player
		if entry.get_network_master() == get_tree().get_network_unique_id():
			player = preload("res://Player/Player.tscn").instance()
		else:
			player = preload("res://Player/Dummy.tscn").instance()
			
		player.name = entry.name
		player.set_network_master(entry.get_network_master())
		
		_players.append(player)
		$SpawnPoint.get_node(str(spawnpoint)).add_child(player)
		spawnpoint += 1


func get_players():
	return _players
	
	
var _players = []
