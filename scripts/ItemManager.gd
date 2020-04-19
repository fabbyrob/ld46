extends Node

enum ItemType {Seed, Mutator, Tomato, Potato, Cucumber}
onready var RNG = get_node("/root/Randomizer")

var ItemTypeToNameMap = {ItemType.Potato:"Potato", 
	ItemType.Cucumber:"Cucumber", 
	ItemType.Tomato:"Tomato", 
	ItemType.Seed:"Seed", 
	ItemType.Mutator:"Mutator"}

var ItemTypeToSceneMap = 	{
	ItemType.Tomato:load("res://scenes/Items/Tomato.tscn"), 
	ItemType.Potato:load("res://scenes/Items/Potato.tscn"), 
	ItemType.Cucumber:load("res://scenes/Items/Cucumber.tscn"), 
	ItemType.Mutator:load("res://scenes/Items/Usable.tscn")
	}
	
var ItemTypeToDescriptionMap = 	{
	ItemType.Tomato:"Juicy delicious tomato.", 
	ItemType.Potato:"Makes the monster need less food, for a time.", 
	ItemType.Cucumber:"Not very filling, but gives extra points!", 
	ItemType.Mutator:"Faintly Glowing Substance.\nMakes plants more likely to mutate.\nMakes the monster poop weird things."
	}
	
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func generate_random_item():
	var new_item_id = Randomizer.sample_enum(ItemType, ItemType.Seed)
	var new_node = ItemTypeToSceneMap[new_item_id].instance()
	return new_node
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
