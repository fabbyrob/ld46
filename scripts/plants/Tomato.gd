extends Plant

func _init():
	 item_type = ItemManager.ItemType.Tomato

func feed(Monster):
		Monster.updateHP($PlantAttributes.food_amount)
		
