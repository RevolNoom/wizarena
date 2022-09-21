extends Node2D


export var Fan_Angle = 0.25*PI # How spread-out the rock formation is

export var Waves = 4
export var Wave_Distance = 100 # How far each wave is separated
export var Wave_Time_Interval = 0.25

export var Damage_Duration = 0.2 # How long after spawn can a Rock deals damage

func _process(delta):
	_spawnTimer += delta
	var supposedWave = _spawnTimer / Wave_Time_Interval + 1
	
	while _waves.size() <= clamp(supposedWave, 0, Waves):
		_spawnWave(_waves.size())
		
	while _spawnTimer > _pacifiedWave * Wave_Time_Interval + Damage_Duration:
		_pacifyRocksInWave(_pacifiedWave)
		
		if _pacifiedWave >= Waves:
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
		rock.position = Vector2(Wave_Distance*(waveNo-1), 0)
		
		if waveNo == 1:
			rock.position = rock.position.rotated(0)
		else:
			# without casting to float, rockNo is an int and the result is rounded to 0 or 1
			rock.position = rock.position.rotated(Fan_Angle * (0.5 - float(rockNo) / (waveNo - 1)))
			
		_waves.back().push_back(rock)
		add_child(rock)
		rock.connect("body_entered", self, "_on_rock_body_entered")


func _on_rock_body_entered(body):
	#TODO: Deal Damage
	pass
	

# Rocks in this waves won't send signal to RockSpawn to deal damage anymore	
func _pacifyRocksInWave(waveNo):
	for rock in _waves[waveNo]:
		rock.disconnect("body_entered", self, "_on_rock_body_entered")
		
	
# A variable to keep references to all spawned rocks
var _waves = [[]]
var _spawnTimer
var _pacifiedWave
