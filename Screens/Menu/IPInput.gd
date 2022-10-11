extends Control

signal connected_to_server

# Called when the node enters the scene tree for the first time.
func _ready():
	var ignore = Network.connect("error", self, "_on_Network_error")
	ignore = get_tree().connect("connected_to_server", self, "_on_connected_to_server")
	if GlobalSettings.Credential[GlobalSettings.NAME] == "":
		$VBoxContainer/Error.text = "Change your name in Settings!"
		
	# NOTE: Debugging, connecting to self host
	Network.SetAsClient("127.0.0.1")



func _on_GO_pressed():
	if GlobalSettings.Credential[GlobalSettings.NAME] == "":
		$VBoxContainer/Error.text = "Change your name in Settings!"
		return
		
	var ip = $VBoxContainer/IP/IP.text
	if ip == "":
		$VBoxContainer/Error.text = "Missing IP"
		return
		
	Network.SetAsClient(str(ip))
	

func _on_connected_to_server():
	emit_signal("connected_to_server")
	
	
func _on_Network_error(msg):
	$VBoxContainer/Error.text = msg


func _on_IP_text_entered(_new_text):
	_on_GO_pressed()
