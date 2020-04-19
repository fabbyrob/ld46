extends Node2D
export (NodePath) var ResumeButton

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_ExitButton_button_down():
	get_tree().change_scene("res://scenes/Splash.tscn")


func _on_PauseButton_button_down():
	var resume_node = get_node(ResumeButton)
	resume_node.show()
	get_tree().paused = true


func _on_MuteButton_button_down():
	pass # Replace with function body.


func _on_ResumeButton_button_down():
	var resume_node = get_node(ResumeButton)
	resume_node.hide()
	get_tree().paused = false