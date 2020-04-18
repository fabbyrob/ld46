extends Node

#SIGNALS
signal field_start_growing
signal field_stop_growing

#PREFABS
var SeedPrefab = preload("res://scenes/Seed.tscn") 

#EXPORTS
export(bool) var plantable = true
export (NodePath) var Inventory 
export (NodePath) var MainScene 

#MEMBERS
var InventoryNode
var planted_attrs : PlantAttributes = null

# Called when the node enters the scene tree for the first time.
func _ready():
	InventoryNode = get_node(Inventory)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func plant(attributes : PlantAttributes):
	#generate a new seed with mutated attributes
	if (planted_attrs == null):
		planted_attrs = attributes.duplicate()
		emit_signal("field_start_growing", $Timer)
		$Timer.start(planted_attrs.growth_time)
	
	print(planted_attrs.mutation_rate)
		
	var new_seed = SeedPrefab.instance()
	get_node(MainScene).add_child(new_seed)
	var attr = new_seed.get_node("PlantAttributes")
	attr.replace_by(attributes.duplicate())
	attr = new_seed.get_node("PlantAttributes")
	attr.mutate()
	new_seed.position = InventoryNode.position
	print(new_seed.get_node("PlantAttributes").mutation_rate)
	return true
	#move the seed to inventory
	#makeseed(attributes.Type, attributes.mutation_rate, ....)


func _on_Timer_timeout():
	# add 4 plants to inventory after mutation
	pass
