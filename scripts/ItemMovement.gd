extends Area2D

#some signals
signal DroppedField
signal DroppedInventory
signal DroppedMonster
signal DroppedTrash

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var dragMouse = false
#var oldPosition
var pickupSource

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if (dragMouse):
		get_parent().position = get_viewport().get_mouse_position()
		
	pass

func click_drag_event(viewport, event, shape_idx):
	if (event is InputEventMouseButton):
		if(event.is_pressed()):#this will do all the mouse buttons right now
			print("Pressed")
			if (dragMouse == false):
				dragMouse = true
				#oldPosition = position
				var areas = get_overlapping_areas()
				pickupSource = null
				for area in areas:
					if (area is ItemSlot):
						#this is our source
						pickupSource = area
						break
				#TODO find out what itemslot we picked up from
		else:
			if (dragMouse == true):
				var areas = get_overlapping_areas()
				var foundNewArea = false
				if (len(areas) > 0):
					for area in areas:
						var _parent = area.get_parent()
						if(_parent is Field):
							emit_signal("DroppedField", _parent, pickupSource)
							foundNewArea = true
							break
						elif (area is InventorySlot):#we're dropping on an inventory slot
							emit_signal("DroppedInventory", area, pickupSource)
							dragMouse = false
							foundNewArea = true
							break
						elif ("Trash" in area.get_name()):#hit a trash can
							emit_signal("DroppedTrash", pickupSource)
							foundNewArea = true
							break
						elif ("Mouth" in area.get_name()):#hit a mouth
							#should check if i'm feedable
							#feed the monster
							var MonsterNode = area.get_parent()
							emit_signal("DroppedMonster", MonsterNode, pickupSource)
							foundNewArea = true
						else:
							#this area isn't valid
							pass
				if (foundNewArea == false):
					#position = oldPosition
					if (pickupSource):
						get_parent().position = pickupSource.position + pickupSource.get_parent().position
					pass
			dragMouse = false

func UpatePosition(pos):
	position = pos

func StopDrag(pos):
	position = pos
	dragMouse = false

func getOtherItem(areasList):
	for area in areasList:
		if area.get_node("Item"):
			return area
	return null



func _on_Control_gui_input(event):
	click_drag_event(null, event, null)
	pass # Replace with function body.


func _on_DraggedThing_input_event(viewport, event, shape_idx):
	click_drag_event(viewport, event, shape_idx)
	pass # Replace with function body.
