extends RichTextLabel
export (NodePath) var TimerNode

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func show_notification():
	var timer = get_node(TimerNode)
	timer.start()
	show()
	



func _on_Timer_timeout():
	hide()
	pass # Replace with function body.
