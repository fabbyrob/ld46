extends Node2D
export (NodePath) var ResumeButton

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var SeedScene = load("res://scenes/Items/Seed.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	var new_plant = SeedScene.instance()
	$Field2.plant(new_plant.get_node("PlantAttributes"))
	new_plant.queue_free()
	$Inventory/InvSlot.set_item($StartingMutator)
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


func _on_Monster_monster_death():
	$GUI/Hints.hide()
	$GUI/EndGame.show()
	get_tree().paused = true


func _on_EndGame_confirmed():
	get_tree().change_scene("res://scenes/Splash.tscn")
