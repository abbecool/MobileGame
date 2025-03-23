extends Area2D

const ROTATION_SPEED = 20
var launched = false
var Rocket = preload("res://scenes/rocket.tscn")
signal launch_rocket

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	rotation_degrees += ROTATION_SPEED * delta

func _input(event):
	if !launched and event.is_action("launch"):
		launched = true
		var rocket = Rocket.instantiate()
		rocket.set_position(position)
		add_sibling(rocket)

func _on_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if !launched and event is InputEventMouseButton:
		emit_signal("launch_rocket")

func _on_launch_rocket() -> void:
	launched = true
	var rocket = Rocket.instantiate()
	rocket.set_position(position)
	add_sibling(rocket)
