extends Plant

func _init():
	 item_type = ItemManager.ItemType.Potato

func feed(Monster):
	Monster.decrease_hunger($PlantAttributes.food_amount)
		
