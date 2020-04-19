extends Node
export (NodePath) var HPbar
export (NodePath) var TimerPath
export var MaxHP = 100
export var HPdecay = -1
export var TimerTick = 1#amount of time in seconds between timer oicks
var CurrentHP
var RangeNode
var TimerNode

signal monster_death

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

func _process(delta):
	RangeNode.set_value(CurrentHP)

func updateHP(val):
	CurrentHP += val
	CurrentHP = clamp(CurrentHP, 0, MaxHP)
	if (CurrentHP <= 0):
		emit_signal("monster_death")
		$AnimationPlayer.stop()

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
func _on_HPTimer_timeout():
	updateHP(HPdecay)
	TimerNode.start(TimerTick)

func spawn_item(node):
	var slot = get_node("InvSlot")
	if (slot.get_item() == null):
		get_tree().get_root().get_node("MainScene").add_child(node)
		slot.set_item(node)
		$SpawnNotification.show_notification()

#on click make an item
func _on_Mouth_input_event(viewport, event, shape_idx):
	if(event is InputEventMouseButton):
		if (event.button_index == BUTTON_LEFT and event.pressed):
			var slot = get_node("InvSlot")
			if (slot.get_item() == null):
				var node = ItemManager.generate_random_item()
				get_tree().get_root().add_child(node)
				slot.set_item(node)
				$PokeNotification.show_notification()
				updateHP(-10)
