extends MenuBar
@export var quit_window : Window
func _on_file_id_pressed(id):
	match id:
		0: #Restart Game
			get_tree().reload_current_scene()
		1: #Restart Level
			SignalBus.reset_level.emit()
		5: #Quit
			quit_window.show()
		_: #not sure if this is possible, but here just in case
			return
	return

func _on_options_id_pressed(id):
	$Options.toggle_item_checked(id)


func _on_help_id_pressed(id):
	pass # Replace with function body.
