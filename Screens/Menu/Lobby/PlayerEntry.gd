extends HBoxContainer

signal exit(self_entry)
signal to_play_queue(self_entry)
signal to_wait_queue(self_entry)

var _stt_msg = {
	Network.DISCONNECTED : "DISCONNECTED",
	Network.WAITING: "WAITING",
	Network.WATCHING: "WATCHING",
	Network.PREPARING: "PREPARING",
	Network.READY: "READY",
	Network.PLAYING: "PLAYING"
}


func _ready():
	Network.connect("status_changed", self, "_on_Network_status_changed")


func SetMaster(status):
	set_network_master(status[Network.ID])
	_assignRole(status)
	_on_Network_status_changed(status)
	_activateButtons(status)


func _assignRole(status):
	if get_network_master() == 1:
		$Role.text = "Host"
	elif Network.get_status()[Network.ID] == status[Network.ID]:
		$Role.text = "You"
	else:
		$Role.text = "Guest"


func _activateButtons(status):
	if Network.get_status()[Network.ID] == 1:
		if status[Network.ID] != Network.get_status()[Network.ID]:
			$Move.disabled = false
		$Exit.disabled = false
	elif status[Network.ID] == Network.get_status()[Network.ID]:
		$Exit.disabled = false
		


func _on_Move_pressed():
	var status = Network.get_status(get_network_master())
	if status[Network.STATUS] == Network.WAITING:
		status[Network.STATUS] = Network.PREPARING
	else:
		status[Network.STATUS] = Network.WAITING
	Network.set_status(status)


# TODO: Rethink disconnect design choice
func _on_Exit_pressed():
	var status = Network.get_status(get_network_master())
	status[Network.STATUS] = Network.DISCONNECTED
	Network.set_status(status)
	emit_signal("exit", self)


func _on_Network_status_changed(status):
	if status[Network.ID] == get_network_master():
		$Name.text = status[Network.NAME]
		$Status.text = _stt_msg[status[Network.STATUS]]
		
		if status[Network.STATUS] == Network.PREPARING:
			$Move.text = "->"
			print("To Play")
			emit_signal("to_play_queue", self)
		elif status[Network.STATUS] == Network.WAITING:
			$Move.text = "<-"
			print("To Wait")
			emit_signal("to_wait_queue", self)
