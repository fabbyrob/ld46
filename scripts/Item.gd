extends Node2D
class_name Item

enum ItemType {Seed, Mutator}
export (ItemType) var item_type 
onready var originalScale = $Sprite.scale

var ItemTypeToSceneMap = 	{
	ItemType.Seed:load("res://scenes/Items/Seed.tscn"), 
	ItemType.Mutator:load("res://scenes/Items/Usable.tscn")
	}

func feedSeed(Monster, Attributes):
		Monster.updateHP(Attributes.food_amount)
		
func feedMutator(Monster):
		Monster.updateHP(-5)
		spawn(ItemType.Mutator, Monster)
		
func _to_string():
	match(item_type):
		ItemType.Seed: return $PlantAttributes.make_tooltip()
		ItemType.Mutator: return "Mutator thing string"
	return ""
	
# Declare member variables here. Examples:
# var a = 2
# var b = "text"

#updates UI stuff of sprite
func update_self():
	if($PlantAttributes):
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

func spawn(item_type, monster):
	#only do this if the item spot is not occupied
	var inv_slot = monster.get_node("InvSlot")
	if (inv_slot.get_item() == null):
		var node = ItemTypeToSceneMap[item_type].instance()
		get_tree().get_root().get_node("MainScene").add_child(node)
		inv_slot.set_item(node)
		monster.get_node("SpawnNotification").show_notification()

func position_in_slot(Slot):
	position = Slot.position + Slot.get_parent().position

func _on_DraggedThing_DroppedField(Field, OldSlot):
	if (OldSlot):
		OldSlot.set_item(null)
	var attr = $PlantAttributes
	var planted = Field.plant(attr)
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
	match(item_type):
		ItemType.Seed: feedSeed(Monster, $PlantAttributes)
		ItemType.Mutator: feedMutator(Monster)
	self.queue_free()
