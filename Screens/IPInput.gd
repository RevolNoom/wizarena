extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	var ignore = Network.connect("error", self, "_on_Network_error")
	ignore = get_tree().connect("connected_to_server", self, "_on_connected_to_server")
	if GlobalSettings.ClientCredential._name == "":
		$Content/VBoxContainer/Error.text = "Change your name in Settings!"



func _on_GO_pressed():
	if GlobalSettings.ClientCredential._name == "":
		$Content/VBoxContainer/Error.text = "Change your name in Settings!"
		return
		
	var ip = $Content/VBoxContainer/IP/IP.text
	if ip == "":
		$Content/VBoxContainer/Error.text = "Missing IP"
		return
		
	Network.SetAsClient(str(ip))
	
	
func _on_BackButton_pressed():
	get_tree().change_scene("res://Screens/Menu.tscn")


func _on_connected_to_server():
	get_tree().change_scene("res://Screens/Lobby.tscn")
	
	
func _on_Network_error(msg):
	$Content/VBoxContainer/Error.text = msg


func _on_IP_text_entered(_new_text):
	_on_GO_pressed()
