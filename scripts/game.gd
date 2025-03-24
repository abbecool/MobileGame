extends Node2D

const GameOverScreen = preload("res://scenes/game_over.tscn")

const GRAVITATIONAL_FORCE = 1e-3
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	set_fuel_bar(100)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func get_real_gravity():
	return GRAVITATIONAL_FORCE

func set_fuel_bar(value):
	$ProgressBar.value = value

func set_game_over_scene(win: bool):
	var game_over = GameOverScreen.instantiate()
	#game_over.set_title(win)
	get_tree().change_scene_to_packed(GameOverScreen)
