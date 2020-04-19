extends TextureProgress


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var timer : Timer
# Called when the node enters the scene tree for the first time.
func _ready():
	timer = get_node("../Timer") as Timer

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if (timer.is_stopped()):
		visible = false
		pass # TODO hide progress wheel
	else:
		visible = true
		
		pass # TODO update wheel based on progress
