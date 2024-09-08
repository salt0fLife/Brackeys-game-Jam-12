extends Node
var playingGame = false
var paused = false

func play_game():
	print_rich("[color=GREEN][i]now playing game[/i]")
	#printerr("play not implemented")
	$MainMenu.hide()
	var lev = load(Settings.mainLevel).instantiate()
	$sceneHandler.add_child(lev)
	playingGame = true
	pass

func _input(_event):
	if Input.is_action_just_pressed("pause"):
		pause_game()
		pass
	pass

func pause_game():
	if playingGame and !paused:
		paused = true
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
		$PauseMenu.visible = true
		get_tree().paused = true
		pass
	pass

func return_to_main_menu():
	print_rich("[color=GREEN][i]returning to Main Menu[/i]")
	for child in $sceneHandler.get_children(false):
		child.queue_free()
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	$MainMenu.visible = true


func _on_play_button_down():
	play_game()


func _on_settings_button_down():
	#printerr("settings not implemented")
	$Settings.visible = true


func _on_quit_button_down():
	quit()


func quit():
	print_rich("[color=GREEN][i]quit the right way[/i]")
	get_tree().quit(3)


func _on_return_to_game_button_down():
	get_tree().paused = false
	$PauseMenu.hide()
	paused = false
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	pass # Replace with function body.


func _on_quit_to_main_menu_button_down():
	return_to_main_menu()
	get_tree().paused = false
	$PauseMenu.hide()
	paused = false
	pass # Replace with function body.
