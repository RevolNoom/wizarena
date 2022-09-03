extends Node

var _player
signal error(msg)

export var MAX_PLAYERS = 2
export var PORT = 7979

class Credential:
	var _id
	var _name
	func _init(id, name):
		_id = id
		_name = name

# Filled in IPInput scene or HostRoom
var _localCred = Credential.new(-1, "")


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


func SetAsServer():
	var server = NetworkedMultiplayerENet.new()
	server.create_server(PORT, MAX_PLAYERS)
	get_tree().network_peer = server
	
	var ignore = get_tree().connect("network_peer_connected", self, "network_peer_connected")
	ignore = get_tree().connect("network_peer_disconnected", self, "network_peer_disconnected")


# Called when a client (and the server itself) connects to the server
func network_peer_connected(id):
	_localCred._id = get_tree().get_network_unique_id()
	rpc_id(id, "RegisterPlayer", _localCred)


func network_peer_disconnected(id):
	_player.erase(id)
	

func connected_to_server():
	# For Debug purpose
	print("Connected")
	

func connection_failed():
	# For Debug purpose
	print("Connection failed")
	

remote func RegisterPlayer(credential):
	_player[get_tree().get_rpc_sender_id()] = credential
	

func server_disconnected():
	# For Debug purpose
	print("Server Disconnected")


