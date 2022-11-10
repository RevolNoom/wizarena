extends HBoxContainer

class_name HostQueue

signal exit()
signal launch_game


func _ready():
	Network.connect("status_changed", self, "UpdateEntryList")
	Network.connect("disconnected", self, "_on_Network_disconnected")


func _on_LobbyDecision_host(name, port):
	Network.SetAsServer(port)
	Network.set_status([get_tree().get_network_unique_id(), name, Network.READY])
	

func AddEntriesFromNetworkList():
	for player in Network._player.keys():
		UpdateEntryList(Network.get_status(player))


# Add a new entry if this player is not in the room
# And leave the entries to update themselves
func UpdateEntryList(status):
	for playerContainer in [$Queue/WaitQueue, $Room/PlayQueue]:
		for playerEntry in playerContainer.get_children():
			if playerEntry.get_network_master() == status[Network.ID]:
				return
	CreateNewPlayerEntry(status)
		
	$Room/Controller/State/Launch.disabled = not isLaunchable()


func isLaunchable():
	for playerEntry in $Room/PlayQueue.get_children():
		if Network.get_status(playerEntry.get_network_master())[Network.STATUS] != Network.READY:
			return false
	return true


func CreateNewPlayerEntry(status):
	var pe = _playerEntry.instance()
	pe.SetMaster(status)
	pe.connect("to_play_queue", self, "_on_PlayerEntry_to_play_queue")
	pe.connect("to_wait_queue", self, "_on_PlayerEntry_to_wait_queue")
	if status[Network.ID] == Network.get_status()[Network.ID]:
		pe.connect("exit", self, "_on_Client_exit")
		
	if status[Network.STATUS] in [Network.READY, Network.PLAYING, Network.PREPARING]:
		$Room/PlayQueue.add_child(pe)
	else:
		$Queue/WaitQueue.add_child(pe)


func _on_Network_disconnected(status):
	for playerContainer in [$Queue/WaitQueue, $Room/PlayQueue]:
		for playerEntry in playerContainer.get_children():
			if status[Network.ID] == playerEntry.get_network_master():
				playerContainer.remove_child(playerEntry)
				playerEntry.queue_free()


func _on_Client_exit(_entry):
	Network.Disconnect()
	for playerContainer in [$Queue/WaitQueue, $Room/PlayQueue]:
		for playerEntry in playerContainer.get_children():
			playerContainer.remove_child(playerEntry)
			playerEntry.queue_free()
			
	emit_signal("exit")


func _on_Launch_pressed():
	emit_signal("launch_game")
		
		
func _on_PlayerEntry_to_wait_queue(entry):
	ToQueue(entry, $Queue/WaitQueue)
	
	
func _on_PlayerEntry_to_play_queue(entry):
	ToQueue(entry, $Room/PlayQueue)


func ToQueue(entry, newnode):
	var oldParent = entry.get_parent()
	if oldParent != newnode:
		oldParent.remove_child(entry)
		newnode.add_child(entry)


var _playerEntry = preload("res://Screens/Menu/Lobby/PlayerEntry.tscn")

