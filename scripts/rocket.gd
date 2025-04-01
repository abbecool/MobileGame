extends CharacterBody2D

const ROCKET_FORCE = 1e4
const G = 2e-3
const MASS = 1e2
const ORBIT_HEIGHT = 150
const ORBIT_SPEED = 3

var screenTouch = false
var fuel = 100
var fuel_consumption = 35
var orbiting_planet
var theta : float

var is_launching : bool = false

signal successful_landing 
signal update_orbiting_planet(planet)

func _ready() -> void:
	#orbiting_planet = get_tree().get_nodes_in_group("planets")[0]
	position = orbiting_planet.get_position()

#func _physics_process(delta: float) -> void:
	#var total_force = Vector2.ZERO
	#var planet_distance = []
	#for planet in get_tree().get_nodes_in_group("planets"):
		#var distance = (planet.get_position() - position)
		#planet_distance.append([planet, distance])
		#if distance.length() < 100:
			#var radius = planet.get_radius()
			#var desired_distance = radius + ORBIT_HEIGHT
			##print("planet radius: ", radius)
			#planet.set_texture("Earth")
			#orbiting_planet = planet
			#break
		#else:
			#planet.set_texture("Mars")
		#orbiting_planet = []
			#
		##var distance_squared = distance.length_squared()
		##if distance_squared == 0:
			##continue  # Avoid division by zero
		##if !planet.has_method("get_mass"):  # Ensure the planet has a get_mass method
			##continue
		##var force_magnitude = (G * mass * planet.get_mass()) / distance_squared
		##var force = distance.normalized() * force_magnitude
		##total_force += force
	##print($OrbitTimer.time_left)
	##if orbiting_planet:
		##position = orbiting_planet.get_position() + Vector2(100,0)
#
	##if screenTouch and fuel>0:
		##fuel -= fuel_consumption * delta
		##total_force += (get_viewport().get_mouse_position() - position).normalized() * ROCKET_FORCE
		##get_parent().set_fuel_bar(fuel)
	##elif fuel <= 0:
		##print("Out of fuel!")
	#
	#apply_central_force(total_force)
	
func _physics_process(delta: float) -> void:
	#theta -= ORBIT_SPEED * delta
	#var orbit_position = ORBIT_HEIGHT * Vector2(cos(theta), sin(theta))
	var planet_distance = []
	for planet in get_tree().get_nodes_in_group("planets"):
		var distance = (planet.get_position() - position)
		planet_distance.append([planet, distance])
		if distance.length() < 150:
			var radius = planet.get_radius()
			#var desired_distance = radius + ORBIT_HEIGHT
			#print("planet radius: ", radius)
			planet.set_texture("Earth")
			var distance_squared = distance.length_squared()
			if distance_squared == 0:
				continue  # Avoid division by zero
			if !planet.has_method("get_mass"):  # Ensure the planet has a get_mass method
				continue
			var force_magnitude = (G * MASS * planet.get_mass()) / distance_squared
			var force = distance.normalized() * force_magnitude * 1e-5
			velocity += force / MASS
			var a = velocity.dot(distance)
			a = a/(velocity.length()*distance.length())
			a = acos(a)
			print(rad_to_deg(a))
		else:
			planet.set_texture("Mars")
	position += velocity

func _on_successful_landing() -> void:
	print("emit")
	#get_tree().change_scene_to_file("res://scenes/game_over.tscn")
	get_parent().set_game_over_scene(true)
	
func landing(win):
	print("emit")
	get_parent().set_game_over_scene(win)
		
func set_orbiting_planet(planet: RigidBody2D) -> void:
	orbiting_planet = planet
	
func _on_update_orbiting_planet(planet) -> void:
	print("rocket")
	set_orbiting_planet(planet)

func _on_touch_area_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventScreenTouch:
		if event.pressed:
			is_launching = true

func _input(event):
	if is_launching and event is InputEventScreenTouch:
		if !event.is_pressed():
			if (position-event.position).length() > 25:
				print("vel: ", (position-event.position))
				is_launching = false
				#apply_central_force((position-event.position)*1e3)
				velocity = (position-event.position)*0.5e-1
				#position = (event.position)
			else:
				print("to slow launch")
