extends LobbyRoom

export var MAX_PLAYERS = 32

func _ready():
	_entryScene = {\
		"Host": preload("res://Screens/Menu/Lobby/Host/YouEntry.tscn"),
		"Guest": preload("res://Screens/Menu/Lobby/Host/GuestEntry.tscn"),
		"You": preload("res://Screens/Menu/Lobby/Host/YouEntry.tscn")
	}


func SetupServer(player_name, port):
	if port is String:
		port = int(port)
	var server = NetworkedMultiplayerENet.new()
	server.create_server(port, MAX_PLAYERS)
	get_tree().network_peer = server
	
	_youEntry = CreateEntry([1, $Room/PlayQueue.get_path(), player_name, "READY"])
	_youEntry.connect("exit", self, "_on_You_exit")
	
# Entry info is stored in an array:
# @0: Sender ID. To distinguishes between host and guests
# @1: Path to wait or play queue
# @2: Player name
# @3: Status ("PLAYING", "WAITING", ...)
# @return: Handle to the created entry, that has been appended to a parent node
remote func CreateEntry(entry_info):
	var entry = .CreateEntry(entry_info)
	entry.connect("move_pressed", self, "_on_Entry_move_pressed")
	entry.connect("exit_pressed", self, "_on_Entry_exit_pressed")
	entry.connect("move", self, "_on_Entry_move")
	entry.connect("exit", self, "_on_Entry_exit")
	entry.connect("status_changed", self, "_on_Entry_status_changed")
	return entry


func _on_Entry_status_changed(_entry):
	$Room/Controller/State/Launch.disabled = not isLaunchable()
	
	
func _on_Entry_move(_entry):
	$Room/Controller/State/Launch.disabled = not isLaunchable()
	

func isLaunchable():
	for entry in $Room/PlayQueue.get_children():
		if entry.get_status() != "READY":
			return false
	return true


func _on_Launch_pressed():
	rpc("InitializeGame")

