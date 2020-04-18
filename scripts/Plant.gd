extends Node

var SeedPreload = preload("res://scenes//JSeed.tscn")

var rng = RandomNumberGenerator.new()

func _ready():
	rng.randomize()

func get_seed(clone = false):
	#create a new blank seed instance
	var _seed = SeedPreload.instance()
	
	#replace the default attributes with a copy of the parent attributes
	_seed.get_node("Attributes").replace_by($Attributes.duplicate())
	
	#optionally mutate
	if !clone && rng.randf() < $Attributes.mutation_rate:
		_seed.get_node("Attributes").mutate()
	
	
	return _seed 
