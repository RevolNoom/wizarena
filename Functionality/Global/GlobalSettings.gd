extends Node

# Network Credential breakdown:
# @0: Network ID
# @1: Player name
var Credential = [-1, ""]

enum{
	ID = 0,
	NAME = 1
}


#func _ready():
func _enter_tree():
	seed(OS.get_unix_time())
	for i in range(0, 6):
		Credential[NAME] += char(ord('a') + randi()%(ord('z') - ord('a')))
	
	var startingSpells = [
		preload("res://Spell/Fireball/Fireball.tscn"), 
		preload("res://Spell/Seisme/Seisme.tscn"),
		preload("res://Spell/Telekinesis/Telekinesis.tscn")]
		
	for i in range(0, 10):
		_EquippedSpells.push_back(startingSpells[i%startingSpells.size()].instance())


# Spells equipped from SpellBook
var _EquippedSpells: Array = []
