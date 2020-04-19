extends Node2D
class_name Item

#i'm over engineering this, stop it me.
enum ItemType {Seed, Mutator}
export (ItemType) var item_type 

func feedSeed(Monster, Attributes):
		Monster.updateHP(Attributes.food_amount)
		
func feedMutator(Monster):
		Monster.updateHP(-5)
		spawn(ItemType.Mutator, Monster)

# Declare member variables here. Examples:
# var a = 2
# var b = "text"



# Called when the node enters the scene tree for the first time.
func _ready():
	#item_type = ItemType.Seed
	pass # Replace with function body.

func spawn(item_type, monster):
	var spawn_point = monster.get_node("SpawnPoint")
	
	pass

func position_in_slot(Slot):
	position = Slot.position + Slot.get_parent().position

func _on_DraggedThing_DroppedField(Field, OldSlot):
	var attr = $PlantAttributes
	var planted = Field.plant(attr)
	if (planted == true):
		get_parent().remove_child(self)
		self.queue_free()
	else:
		pass


func _on_DraggedThing_DroppedInventory(Slot, OldSlot):
	var OtherItem = Slot.swap_item(self) #the inv slot is now aware of what owns what
	if (OldSlot):
		OldSlot.set_item(null)
	if (OtherItem):
		print("Found a friend")
		#remove other item
		OldSlot.set_item(OtherItem)
		#OtherItem.position_in_slot(OldSlot)
	#position_in_slot(Slot)


func _on_DraggedThing_DroppedTrash():
	#get_parent().remove_child(self)
	self.queue_free()


func _on_DraggedThing_DroppedMonster(Monster, OldSlot):
	match(item_type):
		ItemType.Seed: feedSeed(Monster, $PlantAttributes)
		ItemType.Mutator: feedMutator(Monster)
	self.queue_free()
