extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var rng = RandomNumberGenerator.new()

func _ready():
	rng.randomize()


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func sample():
	return rng.randf()
	
func sample_normal(mean, sd):
	return rng.randfn(mean, sd)
	
#samples form a normal, but clamps balue [0,1]
func sample_normal_frac(mean, sd):
	return clamp(rng.randfn(mean, sd), 0.0, 1.0)
	
func sample_enum(my_enum):
	return my_enum.values()[rng.randi()%my_enum.size()]
