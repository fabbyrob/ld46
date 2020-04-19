extends Node2D

class_name PlantAttributes
#TYPES

onready var RNG = get_node("/root/Randomizer")

export(float,0,1,0.05) var mutation_rate = 0.9

export(int,0,100,5) var food_amount = 15

export(float,0,30,0.5) var growth_time = 5

export var color = Color(1,1,1)

func mutate(field_attrs):
	var mutation_modifier = field_attrs.mutation_modifier
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
	return ("T:%s m:%.2f f:%0.2f g:%0.2f c:%s" % [ItemManager.ItemTypeToNameMap[get_parent().item_type], mutation_rate, food_amount, growth_time, color])

func make_tooltip():
	return ("%s\nFood Amt: %.2f\nGrowth Time: %.2f\nMutation Rate: %.2f\n%s" % 
	[ItemManager.ItemTypeToNameMap[get_parent().item_type], food_amount, growth_time, mutation_rate,ItemManager.ItemTypeToDescriptionMap[get_parent().item_type]])
	

func get_size():
	return clamp(food_amount/20, 0.5, 1.0)

func _on_Button_button_down():
	mutate(1.0)
	get_parent().get_node("Sprite").modulate = color
	pass # Replace with function body.
