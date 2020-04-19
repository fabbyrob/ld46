extends Node


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	get_tree().paused = false
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_StartButton_button_down():
	get_tree().change_scene("res://scenes/MainScene.tscn")


func _on_CreditsButton_button_down():
	get_tree().change_scene("res://scenes/Credits.tscn")


func _on_ScoresButton_button_down():
	get_tree().change_scene("res://scenes/Scores.tscn")


func _on_ExitButton_button_down():
	get_tree().quit()


func _on_BackButton_button_down():
	get_tree().change_scene("res://scenes/Splash.tscn")
