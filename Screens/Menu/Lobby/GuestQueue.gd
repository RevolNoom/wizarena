extends HostQueue


func _ready():
	._ready()
	Network.connect("server_disconnected", self, "_on_Network_server_disconnected")

func _on_Launch_toggled(button_pressed):
	var status = Network.get_status()
	status[Network.STATUS] = Network.READY if button_pressed\
											else Network.PREPARING
	Network.set_status(status)


# TODO: Swap inheritance: HostQueue <-> GuestQueue
func UpdateEntryList(status):
	for playerContainer in [$Queue/WaitQueue, $Room/PlayQueue]:
		for playerEntry in playerContainer.get_children():
			if playerEntry.get_network_master() == status[Network.ID]:
				return
	CreateNewPlayerEntry(status)
	
	
func _on_Network_server_connected():
	var status = Network.get_status()
	status[Network.STATUS] = Network.WAITING
	Network.set_status(status)


func _on_PlayerEntry_to_play_queue(entry):
	._on_PlayerEntry_to_play_queue(entry)
	
	if Network.get_status(entry.get_network_master())[Network.ID]\
		== Network.get_status()[Network.ID]:
		$Room/Controller/State/Launch.disabled = false


func _on_PlayerEntry_to_wait_queue(entry):
	._on_PlayerEntry_to_wait_queue(entry)
	
	if Network.get_status(entry.get_network_master())[Network.ID]\
		== Network.get_status()[Network.ID]:
		$Room/Controller/State/Launch.disabled = true


func _on_LobbyDecision_join(name, ip, port):
	Network.SetAsClient(ip, port)
	Network.set_status([get_tree().get_network_unique_id(), name, Network.WAITING])
	Network.connect("server_connected", self, "_on_Network_server_connected", [], CONNECT_ONESHOT)


func _on_Network_server_disconnected():
	_on_Client_exit(null)
