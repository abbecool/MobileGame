extends RigidBody2D

const ROCKET_FORCE = 1e4
const G = 1e-3
const MASS = 1e2
const ORBIT_HEIGHT = 50

var screenTouch = false
var fuel = 100
var fuel_consumption = 35

signal successful_landing 

func _ready() -> void:
	mass = MASS

func _physics_process(delta: float) -> void:
	var total_force = Vector2.ZERO
	for planet in get_tree().get_nodes_in_group("planets"):
		var distance = (planet.get_position() - position)
		if distance.length() < 100:
			var radius = planet.get_radius()
			var desired_distance = radius + ORBIT_HEIGHT
			#print("planet radius: ", radius)
			#planet.set_texture("Earth")
		#else:
			#planet.set_texture("Mars")
			
		var distance_squared = distance.length_squared()
		if distance_squared == 0:
			continue  # Avoid division by zero
		if !planet.has_method("get_mass"):  # Ensure the planet has a get_mass method
			continue
		var force_magnitude = (G * mass * planet.get_mass()) / distance_squared
		var force = distance.normalized() * force_magnitude
		total_force += force

	if screenTouch and fuel>0:
		fuel -= fuel_consumption * delta
		total_force += (get_viewport().get_mouse_position() - position).normalized() * ROCKET_FORCE
		get_parent().set_fuel_bar(fuel)
	elif fuel <= 0:
		print("Out of fuel!")
	
	apply_central_force(total_force)
	
func _input(event):
	if event is InputEventMouseButton:
		screenTouch = event.is_pressed()
		
func set_velocity(vel: Vector2) -> void:
	linear_velocity = vel

func _on_successful_landing() -> void:
	print("emit")
	#get_tree().change_scene_to_file("res://scenes/game_over.tscn")
	get_parent().set_game_over_scene()
	
func landing(win):
	print("emit")
	get_parent().set_game_over_scene(win)
		
