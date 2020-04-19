extends Node

enum ItemType {Seed, Mutator}
onready var RNG = get_node("/root/Randomizer")

var ItemTypeToSceneMap = 	{
	ItemType.Seed:load("res://scenes/Items/Seed.tscn"), 
	ItemType.Mutator:load("res://scenes/Items/Usable.tscn")
	}
	
	
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func generate_random_item():
	var new_item_id = Randomizer.sample_enum(ItemType)
	var new_node = ItemTypeToSceneMap[new_item_id].instance()
	return new_node
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
