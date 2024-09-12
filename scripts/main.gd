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


func pause_game():
	if playingGame and !paused:
		for i in get_tree().get_nodes_in_group("ShopKeeper"):
			i.close_shop()
		for p in get_tree().get_nodes_in_group("Player"):
			p.close_inventory()
		#var p = get_tree().get_first_node_in_group("Player")
		#p.close_inventory()
		paused = true
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
		$PauseMenu.visible = true
		get_tree().paused = true
		pass
	elif playingGame and paused:
		_on_return_to_game_button_down()
	pass

func return_to_main_menu():
	print_rich("[color=GREEN][i]returning to Main Menu[/i]")
	playingGame = false
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

func load_new_scene(path = ""):
	if $sceneHandler.get_child_count(false) > 0:
		for scene in $sceneHandler.get_children(false):
			scene.queue_free()
	var newScene = load(path).instantiate()
	$sceneHandler.add_child(newScene)
	pass

func _on_debug_scene_button_down():
	print_rich("[color=GREEN][i]now debugging game[/i]")
	#printerr("play not implemented")
	$MainMenu.hide()
	var lev = load("res://Levels/debug_level.tscn").instantiate()
	$sceneHandler.add_child(lev)
	playingGame = true
	pass # Replace with function body.
