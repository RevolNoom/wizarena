extends Control


var LOBBY = preload("res://Screens/Menu/Lobby.tscn")
var IPINPUT = preload("res://Screens/Menu/IPInput.tscn")
var GAMEPLAY = preload("res://Screens/Gameplay/Gameplay.tscn")
var SETTINGSCREEN = preload("res://Screens/Menu/SettingScreen.tscn")
var SPELLBOOK = preload("res://Screens/Menu/SpellBook/SpellBook.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _on_Join_pressed():
	ChangeSideWindow(IPINPUT)
	get_node("HBoxContainer/SideWindow/IPInput").connect("connected_to_server", self, "_on_Join_connected_to_server")


func _on_Join_connected_to_server():
	ChangeSideWindow(LOBBY)
	

func _on_Host_pressed():
	Network.SetAsServer()
	ChangeSideWindow(LOBBY)
	
	
func _on_Train_pressed():
	ChangeSideWindow(GAMEPLAY)


func _on_Settings_pressed():
	ChangeSideWindow(SETTINGSCREEN)
	

func _on_SpellBook_pressed():
	ChangeSideWindow(SPELLBOOK)
	

func ChangeSideWindow(scene):
	for optionWindow in $HBoxContainer/SideWindow.get_children():
		$HBoxContainer/SideWindow.remove_child(optionWindow)
		optionWindow.queue_free()		
	$HBoxContainer/SideWindow.add_child(scene.instance())

