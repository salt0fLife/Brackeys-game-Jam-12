extends Control


func _input(_event):
	if Input.is_action_just_pressed("pause"):
		$"..".pause_game()






func _on_warp_to_hub_button_down():
	$"..".pause_game()
	$"..".load_new_scene("res://Levels/island_hub.tscn")
	pass # Replace with function body.
