extends Node

signal error(msg)
signal connected(id)
signal server_connected()
signal server_disconnected()
signal disconnected(status)
signal status_changed(new_status)

export var MAX_PLAYERS = 32
export var DEFAULT_PORT = 7979


var _player = {}


enum{
	ID = 0,
	NAME = 1,
	STATUS = 2,
}

enum{
	DISCONNECTED,
	
	WAITING,
	WATCHING,
	
	PREPARING,
	READY,
	PLAYING
}


func _ready():
	seed(OS.get_unix_time())
		
	var ignore = get_tree().connect("network_peer_connected", self, "network_peer_connected")
	ignore = get_tree().connect("network_peer_disconnected", self, "network_peer_disconnected")
	ignore = get_tree().connect("connection_failed", self, "connection_failed")
	ignore = get_tree().connect("connected_to_server", self, "connected_to_server")
	ignore = get_tree().connect("server_disconnected", self, "server_disconnected")
	

func Disconnect():
	get_tree().network_peer = null
	_player.clear()


func SetAsServer(port):
	if port is String:
		port = int(port)
	var server = NetworkedMultiplayerENet.new()
	server.create_server(port, MAX_PLAYERS)
	get_tree().network_peer = server
	

func SetAsClient(ip, port):
	if port is String:
		port = int(port)
		
	var client = NetworkedMultiplayerENet.new()
	var err = client.create_client(ip, port)
	if err != OK:
		emit_signal("error", "Can't connect to " + str(ip) + ":" + str(port))
		return
		
	get_tree().network_peer = client


# Called when a client (and the server itself) connects to the server
func network_peer_connected(id):
	# Add our entry if it isn't in from the start
	if not _player.has(get_tree().get_network_unique_id()):
		_player[get_tree().get_network_unique_id()] = [get_tree().get_network_unique_id(), "", WAITING]
	set_status(_player[get_tree().get_network_unique_id()])
	emit_signal("connected", id)


func set_status(new_status):
	if get_tree().network_peer.get_connection_status() == NetworkedMultiplayerPeer.CONNECTION_CONNECTED:
		rpc("_rset_status", new_status)
	else:
		_rset_status(new_status)

remotesync func _rset_status(new_status):
	#print("At " + str(get_tree().get_network_unique_id()) + ", set status of " + str(new_status[Network.ID]) + " into " + str(new_status))
	_player[new_status[Network.ID]] = new_status
	emit_signal("status_changed", new_status)
	

func network_peer_disconnected(id):
	var status = _player[id]
	status[Network.STATUS] = DISCONNECTED
	_player.erase(id)
	emit_signal("disconnected", status)
	

func connected_to_server():
	# For Debug purpose
	print("Connected")
	emit_signal("server_connected")
	
	
func server_disconnected():
	# For Debug purpose
	print("Server Disconnected")
	emit_signal("server_disconnected")
	

func get_status(player_id = 0):
	if player_id == 0:
		player_id = get_tree().get_network_unique_id()
	return _player[player_id].duplicate(true)


func connection_failed():
	# For Debug purpose
	print("Connection failed")



