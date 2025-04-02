extends Line2D

@export var planet: StaticBody2D  # Assign the planet node in the editor

func _ready():
	# Initialize the line with two points
	add_point(Vector2.ZERO)  # Start point at the rocket's position
	add_point(Vector2.ZERO)  # End point, will be updated in _process

func _process(delta):
	if planet:
		# Start point: Rocket's position (Line2D's local origin)
		set_point_position(0, Vector2.ZERO)
		# End point: Planet's position relative to the rocket
		var planet_global_position = planet.global_position
		var rocket_global_position = global_position
		var planet_local_position = to_local(planet_global_position)
		set_point_position(1, planet_local_position)

func set_planet(p):
	planet = p
