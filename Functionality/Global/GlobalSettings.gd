extends Node


class Credential:
	var _id
	var _name
	func _init(id, name):
		_id = id
		_name = name

# Filled in IPInput scene or HostRoom
var ClientCredential = Credential.new(-1, "")

func _ready():
	rand_seed(OS.get_unix_time())
	for i in range(0, 6):
		ClientCredential._name += char(ord('a') + randi()%(ord('z') - ord('a')))
