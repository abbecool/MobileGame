extends StaticBody2D

const MASS = 1e9
var RADIUS = 16
const ROTATION_SPEED = 10

var radius_line = [Vector2.ZERO, Vector2.ZERO]
signal orbit

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	add_to_group("planets") # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	queue_redraw()
	#rotation_degrees += ROTATION_SPEED * delta

func _draw():
	draw_arc(Vector2.ZERO, 50, 0, TAU, 64, Color(1, 1, 1), 3, true)
	#draw_line(radius_line[0], radius_line[1], Color(0,1,0), 3)

func set_radius_line(from: Vector2, to: Vector2 = Vector2.ZERO) -> void:
	radius_line[0] = from
	radius_line[1] = to

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

#func _on_crash_area_body_entered(body: Node2D) -> void:
	#if body.has_signal("successful_landing"):
		#print("Crashed on a strange planet!")
		#body.landing(false)

#func _on_crash_area_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	#if event is InputEventMouseButton:
		#emit_signal("orbit")

func _on_orbit() -> void:
	pass
	#var arr  = get_tree().get_nodes_in_group("rocket")
	#if arr != []:
		#var rocket = arr[0]
		#print("not empty")
		#rocket.set_orbiting_planet(self)
	#else:
		#print("empty")
