extends Node2D
class_name Plant

onready var originalScale = $Sprite.scale
var item_type = ItemManager.ItemType.Seed

func feed(Monster):
		Monster.updateHP($PlantAttributes.food_amount)
		
func _to_string():
	return $PlantAttributes.make_tooltip()
		

#updates UI stuff of sprite
func update_self():
	get_node("Sprite").modulate = $PlantAttributes.color
	var new_scale = Vector2($PlantAttributes.get_size(), $PlantAttributes.get_size())
	$Sprite.scale = originalScale*new_scale
	get_node("Control").set_tooltip(_to_string())
		#mayeb scale should be an attribute
	

# Called when the node enters the scene tree for the first time.
func _ready():
	#item_type = ItemType.Seed
	update_self()#just in case
	pass # Replace with function body.

func _on_DraggedThing_DroppedField(Field, OldSlot):
	if (OldSlot):
		OldSlot.set_item(null)
	var attr = $PlantAttributes
	var planted = Field.plant(self)
	if (planted == true):
		get_parent().remove_child(self)
		self.queue_free()
	else:
		if(OldSlot): OldSlot.set_item(self)


func _on_DraggedThing_DroppedInventory(Slot, OldSlot):
	var OtherItem = Slot.get_item() #the inv slot is now aware of what owns what
	if (OldSlot):
		OldSlot.set_item(null)
	if (OtherItem):
		if(OldSlot.get_class() == "InventorySlot"):
			OldSlot.set_item(OtherItem)
			Slot.set_item(self)
		else:
			OldSlot.set_item(self)
	else:
		Slot.set_item(self)


func _on_DraggedThing_DroppedTrash(OldSlot):
	#get_parent().remove_child(self)
	self.queue_free()
	OldSlot.set_item(null)


func _on_DraggedThing_DroppedMonster(Monster, OldSlot):
	if (OldSlot): OldSlot.set_item(null)
	feed(Monster)
	self.queue_free()
