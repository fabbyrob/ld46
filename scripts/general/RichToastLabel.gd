extends RichTextLabel
class_name RichToastLabel

export(float) var duration := 1.0
export(bool) var enabled := true setget _set_enabled

onready var timer : Timer = Timer.new()

func _ready():
	timer.one_shot = true
	timer.autostart = false
	timer.connect("timeout", self, "_on_timeout")

func _on_timeout():
	hide()

func toast():
	if (enabled):
		show()
		timer.start(duration)

func _set_enabled(value : bool):
	enabled = value
	if (not enabled):
		timer.stop()
		_on_timeout()
