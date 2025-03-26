extends RigidBody2D

const ROCKET_FORCE = 1e4
const G = 2e-3
const MASS = 1e2
const ORBIT_HEIGHT = 50
const ORBIT_SPEED = 3

var screenTouch = false
var fuel = 100
var fuel_consumption = 35
var orbiting_planet
var theta : float

signal successful_landing 
signal update_orbiting_planet(planet)

func _ready() -> void:
	mass = MASS
	#orbiting_planet = get_tree().get_nodes_in_group("planets")[0]
	

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
	theta -= ORBIT_SPEED * delta
	var orbit_position = ORBIT_HEIGHT * Vector2(cos(theta), sin(theta))
	position = orbiting_planet.get_position() + orbit_position
	
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
		
func set_orbiting_planet(planet: RigidBody2D) -> void:
	orbiting_planet = planet
# Custom comparator function
func _compare_distance(a, b) -> int:
	# a and b are arrays: [distance, planet]
	if a[0] < b[0]:
		return -1
	elif a[0] > b[0]:
		return 1
	else:
		return 0


func _on_update_orbiting_planet(planet) -> void:
	print("rocket")
	set_orbiting_planet(planet)
