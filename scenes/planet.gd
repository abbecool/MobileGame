extends Area2D

const MASS = 1e5
const ROTATION_SPEED = 20

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	add_to_group("planets") # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	rotation_degrees += ROTATION_SPEED * delta

func get_mass():
	return MASS
