extends Area2D
class_name DraggableArea2D

# EXPORTS
export(NodePath) var node_to_move 
export(bool) var keep_offset = true
export(bool) var drop_in_multiple = false

# VARS
var target = null
var target_offset = null
var is_dragging = false
var pickup_position = null

# SIGNALS
signal picked_up(from_position)
signal put_down(to_position, from_position)
signal dropped_in_area(area, from_position)

# Called when the node enters the scene tree for the first time.
func _ready():
	# if provided, store node that we're moving
	if (node_to_move and has_node(node_to_move)):
		target = get_node(node_to_move)
		
	# connect to input event signals
	.connect("input_event", self, "_on_input_event")
	.connect("mouse_exited", self, "_on_mouse_exited")

# the only thing we should do here is check if mouse is still pressed
# this way, if the mouse is released in a way where the event
# isn't captured by _on_input_event(...) i.e. if mouse is released
# while simultaneously moving too fast, we don't get stuck dragging
func _physics_process(delta):
	if (is_dragging):
		var pos = snap_target_to_mouse() 
		if (not Input.is_mouse_button_pressed(BUTTON_LEFT)):
			is_dragging = false
			var from_position = pickup_position
			pickup_position = null
			emit_signal("put_down", pos, from_position)
			var overlaps = get_overlapping_areas()
			for overlap in overlaps:
				# emit signals for when we drop this on an Area2D
				emit_signal("dropped_in", overlap, from_position)
				if (not drop_in_multiple):
					break

func snap_target_to_mouse():
	if (target):
		var pos = get_global_mouse_position()
		if (keep_offset and target_offset):
			pos -= target_offset
		target.global_position = pos
		return pos

func _on_mouse_exited():
	# if the mouse exits the area while dragging
	# (i.e. the mouse is moving too fast)
	# we also have to move the target
	if (is_dragging):
		snap_target_to_mouse()

func _on_input_event(viewport, event, shape_idx):
	if (event is InputEventMouseButton and event.button_index == BUTTON_LEFT):
		if (event.pressed == true): # start dragging
			if (target):
				pickup_position = target.global_position
				target_offset = get_global_mouse_position() - pickup_position
			is_dragging = true
			emit_signal("picked_up", pickup_position)
			
