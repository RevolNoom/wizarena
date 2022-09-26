extends Control

# TODO: Refactor this scene into 2? HostRoom & GuestRoom

# Called when the node enters the scene tree for the first time.
func _ready():
	Network.connect("new_register", self, "AddNewGuest")
	if get_tree().get_network_unique_id() == 1:
		SetupAsHost()
	else:
		SetupAsGuest()
		
	for player in Network._player.keys():
		AddNewGuest(Network._player[player])


func SetupAsHost():
	$Content/VBoxContainer/Start.visible = true
	$Content/VBoxContainer/HostIP.visible = true
	$Content/VBoxContainer/RoomMaster.visible = false
	
	var localAddresses = ""
	for ip in IP.get_local_addresses():
		localAddresses += str(ip) + "\n"
		
	$Content/VBoxContainer/HostIP/IP.text = localAddresses
	
	
func SetupAsGuest():
	$Content/VBoxContainer/Start.visible = false
	$Content/VBoxContainer/HostIP.visible = false
	$Content/VBoxContainer/RoomMaster.visible = true
	Network.connect("new_register", self, "CheckRoomMaster")
	
	
# Return true if the new user was added successfully
func AddNewGuest(name):
	if $Content/VBoxContainer/Player/Name.get_node_or_null(name) != null:
		return false
		
	var newName = Label.new()
	newName.name = name
	newName.text = name
	$Content/VBoxContainer/Player/Name.add_child(newName)
	return true

# Return true if the new user was removed successfully
func RemoveGuest(name):
	var username = $Content/VBoxContainer/Player/Name.get_node_or_null(name) 
	if username == null:
		return false
	$Content/VBoxContainer/Player/Name.remove_child(username)
	return true


func CheckRoomMaster(_name):
	if Network._player.has(1):
		$Content/VBoxContainer/RoomMaster/Name.text = Network._player[1]


func _on_BackButton_pressed():
	get_tree().network_peer = null
	get_tree().change_scene("res://Screens/Menu.tscn")


func _on_Start_pressed():
	# TODO: Initialize, sync players
	rpc("InitializeGame")

remotesync func InitializeGame():
	get_tree().change_scene("res://Screens/Main.tscn")
