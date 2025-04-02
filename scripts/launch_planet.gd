extends "res://scripts/planet.gd"

var launched = false
var Rocket = preload("res://scenes/rocket.tscn")
signal launch_rocket

func _ready() -> void:
	RADIUS = 32
	add_to_group("planets") # Replace with function body.

#func _process(delta: float) -> void:
	#pass
	#rotation_degrees += ROTATION_SPEED * delta

func _on_launch_rocket() -> void:
	launched = true
	var rocket = Rocket.instantiate()
	var offset = Vector2(75, 0)
	var rocket_velocity = sqrt(get_parent().get_real_gravity()*MASS/offset.length()) * Vector2(0, -1)
	rocket.set_position(position + offset)
	#rocket.set_velocity(rocket_velocity)
	rocket.set_orbiting_planet(self)
	add_sibling(rocket)

func _on_lauch_area_2d_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if !launched and event is InputEventScreenTouch:
		if event.pressed:
			#print("pressed")
			emit_signal("launch_rocket")
		#else:
			#print("not pressed")
			#print(event.position)

#func _on_lauch_area_2d_body_entered(body: Node2D) -> void:
	#if body.has_signal("successful_landing"):
		#print("successful_landing")
		#body.landing(true)
