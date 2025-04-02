extends Line2D

func _ready():
	# Initialize the line with two points
	add_point(Vector2.ZERO)  # Start point at the rocket's position
	add_point(Vector2.ZERO)  # End point, will be updated in _process

func _process(delta):
	pass
