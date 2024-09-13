extends Node3D


# Called when the node enters the scene tree for the first time.

var messages = ["1000 years ago there was a great kingdom", "until one day a evil magician came along", "and brought chaos with him", "he split the earth and cursed the land with pillars embued with his magic", "the people fled, the earth split, and the kingdom floated to the sky", "and so it remained for 1000 years", "until an unknown hero purged the land of the evil magicians curse", "the land floated back down to the earth, and the people celebrated.", "", "they never did find out who saved their land", "but they were eternally grateful", "", "thanks for playing", "game made by @salt0fLife"]


func _ready():
	#Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	$AnimationPlayer.play("Outro")
	await get_tree().create_timer(5).timeout
	for text in messages:
		$RichTextLabel.text += "\n"
		await get_tree().create_timer(1).timeout
		for i in text.length():
			print(i)
			var char = text[i]
			$RichTextLabel.text += char
			await get_tree().create_timer(0.025).timeout
			pass
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	$RichTextLabel/next.visible = true
	
	
	
	
	
	#var main = get_tree().get_first_node_in_group("Main")
	#main.load_new_scene("res://Environment/Cutscenes/credits.tscn")



func _on_next_button_down():
	var main = get_tree().get_first_node_in_group("Main")
	main.return_to_main_menu()
	pass # Replace with function body.
