extends Area2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var dragMouse = false
var oldPosition

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if (dragMouse):
		position = get_viewport().get_mouse_position()
		
	pass


func click_drag_event(viewport, event, shape_idx):
	if (event is InputEventMouseButton):
		if(event.is_pressed()):#this will do all the mouse buttons right now
			if (dragMouse == false):
				dragMouse = true
				oldPosition = position
		else:
			if (dragMouse == true):
				var areas = get_overlapping_areas()
				if (len(areas) > 0):
					var foundNewArea = false
					for area in areas:
						var _parent = area.get_parent()
						if("Field" in _parent.get_name()):#god i hate this
							var attr = $PlantAttributes
							_parent.get_node("FieldScript").plant(attr)
							get_parent().remove_child(self)
							foundNewArea = true
						elif ("Inv" in area.get_name()):#we're dropping on an inventory slot
							#_parent.add_child(self)
							#print(_parent.get_name())
							#print(self.get_parent().get_name())
							
							#check if slot is already occupied, then swap what you are holding
							
							position = area.position+_parent.position
							dragMouse = false
							foundNewArea = true
						else:
							#this area isn't valid
							pass
					if (foundNewArea == false):
						position = oldPosition
				else:
						#we aren't in a valid place to drop items
						#go back home
						position = oldPosition
			dragMouse = false


