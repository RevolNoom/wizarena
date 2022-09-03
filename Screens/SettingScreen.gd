extends Control


func _on_Name_text_changed(new_text):
	GlobalSettings.PlayerName = new_text


func _on_BackButton_pressed():
	get_tree().change_scene("res://Screens/Menu.tscn")
