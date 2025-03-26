extends RigidBody2D

const MASS = 1e9
var RADIUS = 16
const ROTATION_SPEED = 20

signal orbit

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	add_to_group("planets") # Replace with function body.
	mass = MASS

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	rotation_degrees += ROTATION_SPEED * delta

func get_real_mass():
	return MASS
	
func get_real_position():
	return position

func get_radius():
	return RADIUS

func set_texture(str: String) -> void:
	
	if str == "Earth":
		$Sprite2D.texture = preload("res://assets/images/earth.png")
	elif str == "Mars":
		$Sprite2D.texture = preload("res://assets/images/mars.png")

func _on_crash_area_body_entered(body: Node2D) -> void:
	if body.has_signal("successful_landing"):
		print("Crashed on a strange planet!")
		body.landing(false)

func _on_crash_area_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton:
		print("planet test")
		emit_signal("orbit")

func _on_orbit() -> void:
	var ar  = get_tree().get_nodes_in_group("rocket")
	print(ar)
	#if rocket != []:
		#print("not empty")
		#rocket.set_orbiting_planet(self)
	#else:
		#print("empty")
