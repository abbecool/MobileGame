#extends "res://scenes/planet.gd"
#
#var launched = false
#var Rocket = preload("res://scenes/rocket.tscn")
#signal launch_rocket
#
#func _input(event):
	#if !launched and event.is_action("launch"):
		#print("input")
		#launched = true
		#var rocket = Rocket.instantiate()
		#rocket.set_position(position)
		#add_sibling(rocket)
#
#func _on_launch_rocket() -> void:
	#launched = true
	#var rocket = Rocket.instantiate()
	#rocket.set_position(position-Vector2(5, 50))
	#rocket.set_velocity(Vector2(-1, -8))
	#add_sibling(rocket)
#func _on_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	#print("event")
	#if !launched and event is InputEventMouseButton:
		#emit_signal("launch_rocket")
