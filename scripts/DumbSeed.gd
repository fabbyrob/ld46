extends Area2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var dragMouse = false

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
			dragMouse = true
		else:
			if (dragMouse == true):
				var areas = get_overlapping_areas()
				if (len(areas) > 0):
					var _parent = areas[0].get_parent()
					if(_parent.get_name() == "Field"):#god i hate this
						var attr = $PlantAttributes
						_parent.get_node("FieldScript").plant(attr)
						get_parent().remove_child(self)
				else:
					pass#go back to the inventory
			dragMouse = false


