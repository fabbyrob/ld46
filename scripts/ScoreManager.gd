extends Node


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var time_alive = 0
var alive = true

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if alive:
		time_alive += delta
		update_label()
	
func update_label():
	$ScoreLabel.text = "SCORE: %8d" % time_alive 

func _on_Monster_monster_death():
	alive = false
	pass # Replace with function body.
