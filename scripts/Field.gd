extends Node
var SeedPrefab = preload("res://scenes/Seed.tscn") 
export (NodePath) var Inventory 
export (NodePath) var MainScene 
var InventoryPos
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	InventoryPos = get_node(Inventory).position
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func plant(attributes):
	#generate a new seed with mutated attributes
	var new_seed = SeedPrefab.instance()
	get_node(MainScene).add_child(new_seed)
	var attr = new_seed.get_node("PlantAttributes")
	attr.replace_by(attributes.duplicate())
	attr = new_seed.get_node("PlantAttributes")
	attr.mutate()
	new_seed.position = InventoryPos
	print(new_seed.get_node("PlantAttributes").mutation_rate)
	#move the seed to inventory
	#makeseed(attributes.Type, attributes.mutation_rate, ....)
