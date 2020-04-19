extends Node2D

class_name PlantAttributes
#TYPES
enum PlantType {Potato, Cucumber, Turnip}

#EXPORTS
export(PlantType) var plant_type = PlantType.Potato
var PlantTypeMap = {PlantType.Potato:"Potato", PlantType.Cucumber:"Cucumber", PlantType.Turnip:"Turnip"}

onready var RNG = get_node("/root/Randomizer")

export(float,0,1,0.05) var mutation_rate = 0.9

export(int,0,100,5) var food_amount = 15

export(float,0,30,0.5) var growth_time = 5

export var color = Color(1,1,1)

func mutate(mutation_modifier):
	#mutation rate
	if RNG.sample() < (mutation_rate*mutation_modifier):
		mutation_rate = clamp(RNG.sample_normal(mutation_rate, 0.01), 0, 1.0)
	#food amount
	if RNG.sample() < mutation_rate*mutation_modifier:
		food_amount = RNG.sample_normal(food_amount, 2.0)
	#growth time
	if RNG.sample() < mutation_rate*mutation_modifier:
		growth_time = clamp(RNG.sample_normal(growth_time, 2.0), 1.0, 10)
	#color
	if RNG.sample() < mutation_rate*mutation_modifier:
		color = Color(RNG.sample_normal_frac(color.r, 0.1),
						RNG.sample_normal_frac(color.g, 0.1),
						RNG.sample_normal_frac(color.b, 0.1))
						
	print(_to_string())

func _to_string():
	return ("T:%s m:%.2f f:%0.2f g:%0.2f c:%s" % [PlantTypeMap[plant_type], mutation_rate, food_amount, growth_time, color])


func _on_Button_button_down():
	mutate(1.0)
	get_parent().get_node("Sprite").modulate = color
	pass # Replace with function body.
