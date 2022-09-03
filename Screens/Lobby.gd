extends Control

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
	
	$Content/VBoxContainer/HostIP/IP.text = IP.get_local_addresses()[0]
	
	
func SetupAsGuest():
	$Content/VBoxContainer/Start.visible = false
	$Content/VBoxContainer/HostIP.visible = false
	$Content/VBoxContainer/RoomMaster.visible = true
	
	$Content/VBoxContainer/RoomMaster/Name.text = Network._player[1]._name
	
	
# Return true if the new user was added successfully
func AddNewGuest(credential):
	
	var name = credential._name
	
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


func _on_BackButton_pressed():
	get_tree().network_peer = null
	get_tree().change_scene("res://Screens/Menu.tscn")


func _on_Start_pressed():
	pass # Replace with function body.
