extends Control

func _ready():
	load_Values_from_settings()
	pass


func load_Values_from_settings():
	$CategoryHandler/Level1/MouseSensitivity.value = Settings.mouseSensitivity
	$CategoryHandler/Level1/MouseSensDisplay.text = str(Settings.mouseSensitivity)
	$CategoryHandler/Level1/debugMode.text = str(Settings.debugMode)
	$CategoryHandler/Level1/Fullscreen.text = str(Settings.fullscreen)
	pass

func update_settings_from_Values():
	Settings.set_mouseSensitivity($CategoryHandler/Level1/MouseSensitivity.value)


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


func _on_debug_mode_button_down():
	var currentmode = Settings.debugMode
	if currentmode == true:
		$CategoryHandler/Level1/debugMode.text = "false"
		Settings.debugMode = false
		pass
	else:
		$CategoryHandler/Level1/debugMode.text = "true"
		Settings.debugMode = true
		pass
	pass # Replace with function body.



func _on_fullscreen_button_down():
	if Settings.fullscreen:
		Settings.set_fullscreen(false)
		$CategoryHandler/Level1/Fullscreen.text = "false"
	else:
		Settings.set_fullscreen(true)
		$CategoryHandler/Level1/Fullscreen.text = "true"
	pass # Replace with function body.
