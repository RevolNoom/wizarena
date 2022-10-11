extends Control

# TODO: Refactor this scene into 2? HostRoom & GuestRoom

# Called when the node enters the scene tree for the first time.
func _ready():
	Network.connect("connected", self, "AddNewGuest")
	Network.connect("disconnected", self, "RemoveGuest")
	if get_tree().get_network_unique_id() == 1:
		SetupAsHost()
	else:
		SetupAsGuest()
		
	for player in Network._player.keys():
		AddNewGuest(Network._player[player])


func SetupAsHost():
	$VBoxContainer/Start.visible = true
	$VBoxContainer/HostIP.visible = true
	$VBoxContainer/RoomMaster.visible = false
	
	var localAddresses = ""
	for ip in IP.get_local_addresses():
		localAddresses += str(ip) + "\n"
		
	$VBoxContainer/HostIP/IP.text = localAddresses
	
	
func SetupAsGuest():
	$VBoxContainer/Start.visible = false
	$VBoxContainer/HostIP.visible = false
	$VBoxContainer/RoomMaster.visible = true
	$VBoxContainer/RoomMaster/Name.text = Network._player[1][GlobalSettings.NAME]
	
	
# Return true if the new user was added successfully
func AddNewGuest(cred):
	var guestName = cred[GlobalSettings.NAME] 
	if $VBoxContainer/Player/Name.text.find(guestName) != -1:
		return false
		
	$VBoxContainer/Player/Name.text += guestName + "\n"
	return true

# Return true if the new user was removed successfully
func RemoveGuest(cred):
	var guestName = cred[GlobalSettings.NAME] 
	$VBoxContainer/Player/Name.text = $VBoxContainer/Player/Name.text.replace(guestName + "\n", "")



func _on_Start_pressed():
	# TODO: Initialize, sync players
	rpc("InitializeGame")

remotesync func InitializeGame():
	get_tree().change_scene("res://Screens/Gameplay/Gameplay.tscn")
