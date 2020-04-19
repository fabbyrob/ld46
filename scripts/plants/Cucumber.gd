extends Plant

func _init():
	 item_type = ItemManager.ItemType.Cucumber

func feed(Monster):
	get_tree().get_root().get_node("MainScene/ScoreManager").time_alive += $PlantAttributes.food_amount
		
