extends Node2D

# TODO

export var rock_spawn_time_interval = 0.06

export var damage = 30

func _process(delta):
	_spawnTimer += delta
	while _spawnTimer > rock_spawn_time_interval:
		_spawnTimer -= rock_spawn_time_interval
		_notYetEruptedRock.back().Erupt()
		_notYetEruptedRock.pop_back()
		if _notYetEruptedRock.size() == 0:
			set_process(false)
			break


func Spawn():
	_spawnTimer = 0
	_pacifiedWave = 0
	_notYetEruptedRock = $SpawnPoint.get_children()
	_notYetEruptedRock.invert()
	for rock in _notYetEruptedRock:
		rock.SetDetectionMode()
	set_process(true)


# A variable to keep references to all spawned rocks
var _notYetEruptedRock : Array
var _spawnTimer
var _pacifiedWave
