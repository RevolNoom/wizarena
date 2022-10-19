extends Control

signal ip_input(ip)

# Called when the node enters the scene tree for the first time.
func _ready():
	if GlobalSettings.Credential[GlobalSettings.NAME] == "":
		$VBoxContainer/Error.text = "Change your name in Settings!"


func _on_GO_pressed():
	if GlobalSettings.Credential[GlobalSettings.NAME] == "":
		$VBoxContainer/Error.text = "Change your name in Settings!"
		return
		
	var ip = $VBoxContainer/IP/IP.text
	if ip == "":
		$VBoxContainer/Error.text = "Missing IP"
		return
		
	emit_signal("ip_input", ip)
	

	
func _on_Network_error(msg):
	$VBoxContainer/Error.text = msg


func _on_IP_text_entered(_new_text):
	_on_GO_pressed()
