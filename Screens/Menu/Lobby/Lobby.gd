extends HBoxContainer
# TODO: Shows pop up when server disconnect 
# TODO: Shows pop up when server kicks player out


func _ready():
	Network.connect("disconnected", self, "_on_Network_disconnected")
	IgnoreDecisionIfAlreadyInARoom()
	
	
func IgnoreDecisionIfAlreadyInARoom():
	if get_tree().network_peer != null:
		$LobbyDecision.visible = false
		if Network.get_status()[Network.ID] == 1:
			$LobbyDecision.visible = false
			$HostQueue.visible = true
		else:
			$LobbyDecision.visible = false
			$GuestQueue.visible = true

# TODO: I don't like Lobby way of do Network setup
# It should be done by each Queue
func _on_LobbyDecision_host(_name, _port):
	$LobbyDecision.visible = false
	$HostQueue.visible = true


func _on_LobbyDecision_join(_name, _ip, _port):
	$LobbyDecision.visible = false
	$GuestQueue.visible = true


func AddQueue(queueScene):
	add_child(queueScene)
	queueScene.name = "Queue"
	queueScene.connect("exit", self, "_on_Queue_exit", [], CONNECT_ONESHOT)
	

func _on_Queue_exit():
	$LobbyDecision.visible = true
	$HostQueue.visible = false
	$GuestQueue.visible = false
	

remotesync func InitializeGame():
	get_tree().change_scene("res://Screens/Gameplay/Gameplay.tscn")


func _on_HostQueue_launch_game():
	rpc("InitializeGame")
	
var _scenes = {
	"HostQueue": preload("res://Screens/Menu/Lobby/HostQueue.tscn"),
	"GuestQueue": preload("res://Screens/Menu/Lobby/GuestQueue.tscn")
}


