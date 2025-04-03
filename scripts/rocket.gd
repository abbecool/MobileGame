extends RigidBody2D

const ROCKET_FORCE = 1e3
const G = 1e-3
const MASS = 1e2
const ORBIT_HEIGHT = 140
const ORBIT_SPEED = 3

var screenTouch = false
var fuel = 100
var fuel_consumption = 35
var orbiting_planet
var theta : float
var new_linear_velocity

var is_launching : bool = false

@onready var velocity_line: Line2D = $Line2D2

signal successful_landing 
signal update_orbiting_planet(planet)

func _ready() -> void:
	
	mass = MASS
	#orbiting_planet = get_tree().get_nodes_in_group("planets")[0]
	#position = orbiting_planet.get_position()
	
func _physics_process(delta: float) -> void:
	#theta -= ORBIT_SPEED * delta
	#var orbit_position = ORBIT_HEIGHT * Vector2(cos(theta), sin(theta))
	var planet_distance = []
	var total_force = Vector2.ZERO
	var distance
	var angle = 0
	for planet in get_tree().get_nodes_in_group("planets"):
		distance = (planet.get_position() - position)
		var radius = planet.get_radius()
		planet.set_texture("Earth")
		var distance_squared = distance.length_squared()
		if distance_squared == 0:
			continue  # Avoid division by zero
		if !planet.has_method("get_real_mass"):  # Ensure the planet has a get_mass method
			continue
		var force_magnitude = (get_parent().get_real_gravity() * MASS * planet.get_real_mass()) / distance_squared
		var force = distance.normalized() * force_magnitude
		total_force += force
		if distance.length() < 200:
			orbiting_planet = planet
			angle = acos(distance.dot(linear_velocity)/(distance.length()*linear_velocity.length()))
			#print(rad_to_deg(angle))
			var radius_vector = Vector2(linear_velocity.y, -linear_velocity.x).normalized() * ORBIT_HEIGHT
			planet.set_radius_line(radius_vector, -1*radius_vector)
			#print(rad_to_deg(a))
			$Line2D.set_planet(planet)
			var new_velocity_dir = Vector2(-distance.y, distance.x).normalized()
			var new_velocity = sqrt(get_parent().get_real_gravity() * orbiting_planet.get_real_mass() / ORBIT_HEIGHT)
			new_linear_velocity = new_velocity_dir*new_velocity
				
		else:
			planet.set_texture("Mars")
	queue_redraw()
	#velocity_line.points = [Vector2.ZERO, velocity.normalized()*1000]
	#position += velocity * delta
	apply_central_force(total_force)
	if abs(rad_to_deg(angle) - 90) < 1: # velocity angle tangental to orbit, cancel excess tangential velocity
		print("Tangentiall")
		print("angle: ", rad_to_deg(angle))
		print("new vel: ", new_linear_velocity, "\n", linear_velocity)
		#linear_velocity = 0.5*new_linear_velocity + 0.5*linear_velocity
		linear_velocity = new_linear_velocity
	#rotation_degrees = 90+rad_to_deg(acos(Vector2(1,0).dot(linear_velocity)/(Vector2(1,0).length()*linear_velocity.length())))
	#rotation_degrees = rad_to_deg(angle)
	

func _draw():
	#draw_line(Vector2.ZERO, linear_velocity.normalized()*1000, Color(1,0,0), 3)
	draw_line(Vector2.ZERO, new_linear_velocity, Color(1,1,0), 5)
	draw_line(Vector2.ZERO, linear_velocity, Color(1,0,1), 3)

#func _on_successful_landing() -> void:
	#print("emit")
	##get_tree().change_scene_to_file("res://scenes/game_over.tscn")
	#get_parent().set_game_over_scene(true)
	
func landing(win):
	print("emit")
	get_parent().set_game_over_scene(win)
	
func set_velocity(vel):
	linear_velocity = vel
		
func set_orbiting_planet(planet: StaticBody2D) -> void:
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
				#print("vel: ", (position-event.position))
				is_launching = false
				apply_central_force((position-event.position)*ROCKET_FORCE)
				#linear_velocity = (position-event.position)*ROCKET_FORCE
				#position = (event.position)
			else:
				print("to slow launch")
