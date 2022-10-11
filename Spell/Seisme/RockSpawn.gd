extends Node2D


export var fan_angle = 0.25*PI # How spread-out the rock formation is

export var waves = 4
export var wave_distance = 100 # How far each wave is separated
export var wave_time_interval = 0.25

export var damage = 30
export var damage_duration = 0.2 # How long after spawn can a Rock deals damage

func _process(delta):
	_spawnTimer += delta
	var supposedWave = _spawnTimer / wave_time_interval + 1
	
	while _waves.size() <= clamp(supposedWave, 0, waves):
		_spawnWave(_waves.size())
		
	while _spawnTimer > _pacifiedWave * wave_time_interval + damage_duration:
		_pacifyRocksInWave(_pacifiedWave)
		
		if _pacifiedWave >= waves:
			set_process(false)
			
		_pacifiedWave += 1
		if _pacifiedWave >= _waves.size():
			break



func Spawn():
	_spawnTimer = 0
	_pacifiedWave = 0
	_waves = [[]]
	set_process(true)
	
	
func _spawnWave(waveNo):
	var rocktscn = preload("res://Spell/Seisme/Rock.tscn")
	
	_waves.push_back([])
	for rockNo in range(0, waveNo):
		var rock = rocktscn.instance()
		rock.position = Vector2(wave_distance*(waveNo-1), 0)
		
		if waveNo == 1:
			rock.position = rock.position.rotated(0)
		else:
			# without casting to float, rockNo is an int and the result is rounded to 0 or 1
			rock.position = rock.position.rotated(fan_angle * (0.5 - float(rockNo) / (waveNo - 1)))
			
		_waves.back().push_back(rock)
		add_child(rock)
		rock.connect("body_entered", self, "_on_rock_body_entered")


func _on_rock_body_entered(body):
	if body is Dummy:
		body.get_node("Health").TakeDamage(damage)
	

# Rocks in this waves won't send signal to RockSpawn to deal damage anymore	
func _pacifyRocksInWave(waveNo):
	for rock in _waves[waveNo]:
		rock.disconnect("body_entered", self, "_on_rock_body_entered")
		
	
# A variable to keep references to all spawned rocks
var _waves = [[]]
var _spawnTimer
var _pacifiedWave
