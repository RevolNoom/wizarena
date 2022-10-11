extends Control

func _ready():
	$VBoxContainer/HBoxContainer/Name.text = GlobalSettings.Credential[GlobalSettings.NAME]


func _on_Name_text_changed(new_text):
	 GlobalSettings.Credential[GlobalSettings.NAME] = new_text
