extends Control

var messageOptions = [["Frisk", "", "stay determined"], ["if at first you dont succeed", "try", "try again"], ["dont give up!", "you were almost there!"], ["hey you", "", "your finally awake"], ["rise", "tarnished", "fulfill your destiny"], ["I was in the caves the other day", "", "I saw something that scared me"], ["actual tip:", "there are chests hidden in the world", "if you see one, hit it", "it might give you something powerful"]]


# Called when the node enters the scene tree for the first time.
func _ready():
	var messages = messageOptions.pick_random()
	if Settings.hasBossDied == false:
		messages = ["you may have died...", "but you may always try again", "you will never lose anything for trying", "but you must defeat every pillar in order to succeed", "", "good luck"]
		Settings.hasBossDied = true
	
	for text in messages:
		$RichTextLabel.text += "\n"
		await get_tree().create_timer(1).timeout
		for i in text.length():
			print(i)
			var char = text[i]
			$RichTextLabel.text += char
			await get_tree().create_timer(0.025).timeout
			pass
	await get_tree().create_timer(2).timeout
	var main = get_tree().get_first_node_in_group("Main")
	main.load_new_scene("res://Levels/island_hub.tscn")
	pass # Replace with function body.
