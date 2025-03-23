extends CharacterBody2D

const FORCE = 100.0
const MASS = 10
var screenTouch = false
#signal screenTouched
func _physics_process(delta: float) -> void:
	if screenTouch:
		velocity += (get_viewport().get_mouse_position()-position).normalized() * FORCE * delta
	move_and_slide()
	
func _input(event):
	if event is InputEventMouseButton:
		screenTouch = event.is_pressed()
