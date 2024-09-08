extends Control

func _ready():
	load_Values_from_settings()
	pass


func load_Values_from_settings():
	$CategoryHandler/Level1/MouseSensitivity.value = Settings.mouseSensitivity
	$CategoryHandler/Level1/MouseSensDisplay.text = str(Settings.mouseSensitivity)
	pass

func update_settings_from_Values():
	Settings.set_mouseSensitivity($CategoryHandler/Level1/MouseSensitivity.value)
	pass


func _on_save_and_exit_button_down():
	update_settings_from_Values()
	for player in get_tree().get_nodes_in_group("Player"):
		if player.has_method("update_values_from_settings"):
			player.update_values_from_settings()
	self.hide()
	pass # Replace with function body.


func _on_mouse_sensitivity_drag_ended(_value_changed):
	$CategoryHandler/Level1/MouseSensDisplay.text = str($CategoryHandler/Level1/MouseSensitivity.value)
	pass # Replace with function body.
