extends Node2D

func _ready():
	LoadPlayers()


func LoadPlayers():
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
		
		$SpawnPoint.get_node(str(spawnpoint)).add_child(player)
		spawnpoint += 1
