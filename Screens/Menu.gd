extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _on_Join_pressed():
	get_tree().change_scene("res://Screens/IPInput.tscn")
	
func _on_Host_pressed():
	Network.SetAsServer()
	get_tree().change_scene("res://Screens/Lobby.tscn")
	
func _on_Train_pressed():
	pass

func _on_Settings_pressed():
	get_tree().change_scene("res://Screens/SettingScreen.tscn")
	


func _on_BackButton_pressed():
	print("Menu back pressed")
	pass # Replace with function body.
