extends Node

class_name Field

#PREFABS
var SeedScene = load("res://scenes/Items/Seed.tscn")

#EXPORTS
export(Fakeenum.NamedEnum) var x #= Fakeenum.NamedEnum.ONE
export(bool) var plantable = true
export var mutation_modifier = 1.0

#MEMBERS
var field_attrs = FieldAttributes.new()
var planted_attrs = null

#METHODS

func plant(attributes):
	#generate a new seed with mutated attributes
	if (plantable):
		#delete any existing plants
		for i in range(1, 5):
			var plot = get_node("plot%d" % [i])
			if (plot.get_item()):
				plot.get_item().queue_free()
				plot.set_item(null)
		#store the planted attributes
		planted_attrs = attributes.duplicate()
		#start the growth timer
		$Timer.start(planted_attrs.growth_time)
		$GrowthProgressRadial.set_max(planted_attrs.growth_time*100)
		#prevent any more planting
		print(planted_attrs.mutation_rate)
		return true
	else:
		return false

func is_empty():
	if (planted_attrs != null):
		return false
		
	for i in range(1, 5):
		if (get_node("plot%d" % [i]).get_item()):
			return false
	return true

func _on_Timer_timeout():
	#stop timer
	$Timer.stop()
	# add 4 plants to field area, with/without mutation
	for i in range(4):
		var grown_attrs = planted_attrs.duplicate()
		var new_plant = SeedScene.instance()
		new_plant.get_node("PlantAttributes").replace_by(grown_attrs)
		get_tree().get_root().get_node("MainScene").add_child(new_plant)
		grown_attrs.mutate(field_attrs)
		new_plant.update_self() 
		#add plant item to scene in one of the field slots
		var plot = get_node("plot%d" % [i+1]) as ItemSlot
		plot.set_item(new_plant)
		
	planted_attrs.queue_free()
	planted_attrs = null
