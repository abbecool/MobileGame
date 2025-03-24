extends RigidBody2D

const ROCKET_FORCE = 1000.0
const G = 1e-4
const MASS = 1e2
var screenTouch = false

var velocity = Vector2(0,0)
var acceleration = Vector2(0,0)

func _physics_process(delta: float) -> void:
	var total_force = Vector2.ZERO
	for planet in get_tree().get_nodes_in_group("planets"):
		var distance = planet.global_position - global_position
		var distance_squared = distance.length_squared()
		if distance_squared == 0:
			continue  # Avoid division by zero
		if !planet.has_method("get_mass"):  # Ensure the planet has a get_mass method
			continue
		var force_magnitude = (G * MASS * planet.get_mass()) / distance_squared
		var force = distance.normalized() * force_magnitude
		if force.length()>2000:
			print(force)
		total_force += force/MASS
	velocity += total_force * delta

	if screenTouch:
		acceleration = (get_viewport().get_mouse_position()-Vector2(180,390)).normalized() * ROCKET_FORCE * delta / MASS
		velocity += acceleration
	position += velocity
	
func _input(event):
	if event is InputEventMouseButton:
		screenTouch = event.is_pressed()
