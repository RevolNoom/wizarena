extends Control


var LOBBY = preload("res://Screens/Menu/Lobby.tscn").instance()
var SPELLBOOK = preload("res://Screens/Menu/SpellBook/SpellBook.tscn").instance()

#var IPINPUT = preload("res://Screens/Menu/IPInput.tscn")
var GAMEPLAY = preload("res://Screens/Gameplay/Gameplay.tscn")
#var SETTINGSCREEN = preload("res://Screens/Menu/SettingScreen.tscn")

func _ready():
	Network.connect("connected", self, "_on_server_connected")
	_on_Train_pressed()


func _enter_tree():
	get_tree().network_peer = null
	$MarginContainer/HBox/VBox/HBox/Name.text = GlobalSettings.Credential[GlobalSettings.NAME]
	$MarginContainer/HBox/VBox/Host_Join/Info/ServerPort.text = str(Network.DEFAULT_PORT)
	$MarginContainer/HBox/VBox/Host_Join/Info/Address/ClientPort.text = str(Network.DEFAULT_PORT)


func _on_Host_pressed():
	if get_tree().network_peer == null or get_tree().get_network_unique_id() != 1:
		Network.SetAsServer(int($MarginContainer/HBox/VBox/Host_Join/Info/ServerPort.text))
	ChangeSideWindow(LOBBY)
	
	
func _on_Join_pressed():
	Network.SetAsClient(\
		$MarginContainer/HBox/VBox/Host_Join/Info/Address/IP.text,\
		int($MarginContainer/HBox/VBox/Host_Join/Info/Address/ClientPort.text))
	ChangeSideWindow(LOBBY)
	
	
func _on_Train_pressed():
	Network.SetAsServer(int($MarginContainer/HBox/VBox/Host_Join/Info/ServerPort.text))
	get_tree().change_scene_to(GAMEPLAY)


#func _on_Settings_pressed():
#	get_tree().network_peer = null
#	ChangeSideWindow(SETTINGSCREEN)
	

func _on_SpellBook_pressed():
	ChangeSideWindow(SPELLBOOK)
	

func _on_server_connected(_credential):
	ChangeSideWindow(LOBBY)
	

#TODO: Change name on other machines
func _on_Name_text_changed(new_text):
	GlobalSettings.Credential[GlobalSettings.NAME] = new_text
	

func ChangeSideWindow(scene):
	var sw = $MarginContainer/HBox/SideWindow
	for child in sw.get_children():
		sw.remove_child(child)
	sw.add_child(scene)
