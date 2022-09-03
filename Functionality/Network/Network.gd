extends Node

var _player = {}
signal error(msg)
signal new_register(credential)

export var MAX_PLAYERS = 2
export var PORT = 7979


func SetAsClient(ip):
	var ignore = get_tree().connect("network_peer_connected", self, "network_peer_connected")
	ignore = get_tree().connect("network_peer_disconnected", self, "network_peer_disconnected")
	ignore = get_tree().connect("connection_failed", self, "connection_failed")
	ignore = get_tree().connect("connected_to_server", self, "connected_to_server")
	ignore = get_tree().connect("server_disconnected", self, "server_disconnected")
	
	var client = NetworkedMultiplayerENet.new()
	var err = client.create_client(ip, PORT)
	if err != null:
		emit_signal("error", "Can't connect to " + str(ip) + ":" + str(PORT))
		return
	get_tree().network_peer = client
	
	GlobalSettings.ClientCredential._id = get_tree().get_network_unique_id()
	RegisterPlayer(GlobalSettings.ClientCredential)
	print("SetAsClient")


func SetAsServer():
	var server = NetworkedMultiplayerENet.new()
	server.create_server(PORT, MAX_PLAYERS)
	get_tree().network_peer = server
	
	var ignore = get_tree().connect("network_peer_connected", self, "network_peer_connected")
	ignore = get_tree().connect("network_peer_disconnected", self, "network_peer_disconnected")
	
	GlobalSettings.ClientCredential._id = get_tree().get_network_unique_id()
	
	RegisterPlayer(GlobalSettings.ClientCredential)
	print("SetAsServer")


# Called when a client (and the server itself) connects to the server
func network_peer_connected(id):
	print("New peer: " + str(id))
	rpc_id(id, "RegisterPlayer", GlobalSettings.ClientCredential)


func network_peer_disconnected(id):
	_player.erase(id)
	

func connected_to_server():
	# For Debug purpose
	print("Connected")
	

func connection_failed():
	# For Debug purpose
	print("Connection failed")
	

remote func RegisterPlayer(credential):
	_player[credential._id] = credential
	emit_signal("new_register")
	

func server_disconnected():
	# For Debug purpose
	print("Server Disconnected")


