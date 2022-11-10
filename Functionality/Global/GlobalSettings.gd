extends Node



#func _ready():
func _enter_tree():
	
	var startingSpells = [
		preload("res://Spell/Fireball/Fireball.tscn"), 
		preload("res://Spell/Seisme/Seisme.tscn"),
		preload("res://Spell/Telekinesis/Telekinesis.tscn")]
		
	for i in range(0, 10):
		_EquippedSpells.push_back(startingSpells[i%startingSpells.size()].instance())


# Spells equipped from SpellBook
var _EquippedSpells: Array = []
