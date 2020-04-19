extends Node
export (NodePath) var HPbar
export (NodePath) var TimerPath
export var MaxHP = 100
export var HPdecay = -1
export var TimerTick = 1#amount of time in seconds between timer oicks
var CurrentHP
var RangeNode
var TimerNode

signal Feed

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	#set pup HP bar
	RangeNode  = get_node(HPbar).get_node("Gauge")
	RangeNode.set_max(MaxHP)
	RangeNode.set_value(MaxHP)
	CurrentHP = RangeNode.get_value()
	#set up Timer for HP bar
	TimerNode = get_node(TimerPath)
	TimerNode.start(TimerTick)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func Death():
	print("She's DEAD!")


func updateHP(val):
	RangeNode.set_value(RangeNode.get_value()+val)
	CurrentHP = RangeNode.get_value()
	if (CurrentHP == 0):
		Death()

func _on_Button_button_down():
	print(CurrentHP)
	updateHP(5)
	pass # Replace with function body.


func _on_Button2_button_down():
	print(CurrentHP)
	updateHP(-5)
	pass # Replace with function body.

#every timer tick decreases HP
#then restarts the timer
func _on_Timer_timeout():
	updateHP(HPdecay)
	TimerNode.start(TimerTick)
	pass # Replace with function body.
