extends Node

#i'm over engineering this, stop it me.
enum ItemType {Seed, Mutator}
var ItemList

class InventoryItem:
	var type
	var name
	
	func _init(t, n):
		type = t
		name = n
		
	func applyItem():
		pass
		
class SeedItem extends InventoryItem:
	func applyItem():
		print("Do seed stuff")
		
class MutatorItem extends InventoryItem:
	func applyItem():
		print("Do mutator stuff")

# Declare member variables here. Examples:
# var a = 2
# var b = "text"



# Called when the node enters the scene tree for the first time.
func _ready():
	ItemList = []
	ItemList.append(InventoryItem.new(ItemType.Seed, "Tomato Seed"))
	ItemList.append(InventoryItem.new(ItemType.Mutator, "Mutator"))
	pass # Replace with function body.

func DroppedItem(item):
	item.applyItem()

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
