extends Control

func _ready():
	$Content/VBoxContainer/HBoxContainer/Name.text = GlobalSettings.ClientCredential._name


func _on_Name_text_changed(new_text):
	 GlobalSettings.ClientCredential._name = new_text


func _on_BackButton_pressed():
	get_tree().change_scene("res://Screens/Menu.tscn")
