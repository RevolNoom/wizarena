extends Node

var _player = {}
signal error(msg)
signal connected(credential)
signal disconnected(credential)

export var MAX_PLAYERS = 2
export var DEFAULT_PORT = 7979


func _ready():
	var ignore = get_tree().connect("network_peer_connected", self, "network_peer_connected")
	ignore = get_tree().connect("network_peer_disconnected", self, "network_peer_disconnected")
	ignore = get_tree().connect("connection_failed", self, "connection_failed")
	ignore = get_tree().connect("connected_to_server", self, "connected_to_server")
	ignore = get_tree().connect("server_disconnected", self, "server_disconnected")
	

func SetAsClient(ip, port):
	var client = NetworkedMultiplayerENet.new()
	var err = client.create_client(ip, port)
	if err != OK:
		emit_signal("error", "Can't connect to " + str(ip) + ":" + str(port))
		return
	get_tree().network_peer = client
	
	GlobalSettings.Credential[GlobalSettings.ID] = get_tree().get_network_unique_id()
	RegisterPlayer(GlobalSettings.Credential)


func SetAsServer(port):
	var server = NetworkedMultiplayerENet.new()
	server.create_server(port, MAX_PLAYERS)
	get_tree().network_peer = server
	
	GlobalSettings.Credential[GlobalSettings.ID] = get_tree().get_network_unique_id()
	RegisterPlayer(GlobalSettings.Credential)


# Called when a client (and the server itself) connects to the server
func network_peer_connected(id):
	# rpc_id or rpc?
	rpc_id(id, "RegisterPlayer", GlobalSettings.Credential)


func network_peer_disconnected(id):
	#print ("Disconnected: " + str(id))
	var cred = _player[id]
	_player.erase(id)
	emit_signal("disconnected", cred)
	

func connected_to_server():
	# For Debug purpose
	print("Connected")
	

func connection_failed():
	# For Debug purpose
	print("Connection failed")
	

remote func RegisterPlayer(credential):
	#print("Registering credential: " + str(credential))
	_player[credential[GlobalSettings.ID]] = credential
	emit_signal("connected", credential)
	

func server_disconnected():
	# For Debug purpose
	print("Server Disconnected")


