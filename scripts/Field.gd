extends Node

class_name Field

#EXPORTS
export(bool) var plantable = true

#MEMBERS
var planted_attrs : PlantAttributes = null

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func plant(attributes : PlantAttributes):
	#generate a new seed with mutated attributes
	if (planted_attrs == null && plantable):
		#store the planted attributes
		planted_attrs = attributes.duplicate()
		#start the growth timer
		$Timer.start(planted_attrs.growth_time)
		$GrowthProgressRadial.set_begin(planted_attrs.growth_time)
		$GrowthProgressRadial.set_end(0)
		#prevent any more planting
		plantable = false
		print(planted_attrs.mutation_rate)
		return true
	else:
		return false
	

func _on_Timer_timeout():
	# add 4 plants to field area, with/without mutation
	for i in range(4):
		var grown_attrs = planted_attrs.duplicate()
		grown_attrs.mutate()
		#TODO create a plant item with these grown_attrs
		#TODO add plant item to scene in one of the field slots
		pass
	planted_attrs.queue_free()
	plantable = true
