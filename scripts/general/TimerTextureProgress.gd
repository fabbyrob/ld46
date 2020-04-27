extends TextureProgress

export(NodePath) var timer_node : NodePath

var timer : Timer

func _ready():
	if (timer_node and has_node(timer_node)):
		var n = get_node(timer_node)
		if (n is Timer):
			timer = n as Timer

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if (timer.is_stopped()):
		visible = false
	else:
		max_value = timer.wait_time * 100
		value = timer.time_left * 100
