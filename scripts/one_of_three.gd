extends StaticBody3D
@export var identityInt := 1
@export var teleport = true

func take_damage(amount = 1, type = -1, _kb = Vector3(0,0,0)):
	unlock()
	pass

func unlock():
	var sceneToLoad = "res://Levels/island_hub.tscn"
	var main = get_tree().get_first_node_in_group("Main")
	if identityInt == 1:
		if Settings.oneUnlocked != true:
			sceneToLoad = "res://Environment/Cutscenes/new_level_unlocked_anim.tscn"
			pass
		pass
	elif identityInt == 2:
		if Settings.twoUnlocked != true:
			sceneToLoad = "res://Environment/Cutscenes/new_level_unlocked_anim.tscn"
			pass
		pass
	else:
		if Settings.threeUnlocked != true:
			sceneToLoad = "res://Environment/Cutscenes/new_level_unlocked_anim.tscn"
			pass
		pass
	Settings.unlockGatePart(identityInt)
	if teleport:
		main.load_new_scene(sceneToLoad)
	pass
