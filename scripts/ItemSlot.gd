extends Area2D

class_name ItemSlot

var _item : Item = null

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func get_item():
	return _item

func set_item(item):
	_item = item

func swap_item(item):
	var old_item = _item
	_item = item
	return old_item

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
