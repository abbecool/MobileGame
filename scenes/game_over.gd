extends CanvasLayer

#onready var title = $PanelContainer/MarginContainer/Rows/Title
@onready var title = $PanelContainer/MarginContainer/Rows/Title

#func _ready() -> void:
	#title = $PanelContainer/MarginContainer/Rows/Title
	
func set_title(win: bool) -> void:
	if win:
		title.text = "You won!"
	else:
		title.text = "Game over!"

func _on_restart_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/game.tscn")

func _on_quit_button_pressed() -> void:
	get_tree().quit()
