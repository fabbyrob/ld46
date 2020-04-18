extends Object

#TYPES
enum PlantType {Potato, Cucumber, Turnip}

#EXPORTS
export(PlantType) var plant_type = PlantType.Potato

export(float,0,1,0.05) var mutation_rate = 0.1

export(int,0,100,5) var food_amount = 15

export(float,0,30,0.5) var growth_time = 10

func mutate():
	mutation_rate += Randomizer.sample()
	print("post mutation %s" % mutation_rate)
