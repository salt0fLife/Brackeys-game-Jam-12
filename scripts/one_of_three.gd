extends StaticBody3D
@export var identityInt := 1
@export var teleport = true

func take_damage(amount = 1, type = -1, _kb = Vector3(0,0,0)):
	unlock()
	pass

func _ready():
	var activated = false
	if identityInt == 1 and Settings.oneUnlocked == true:
		activated = true
	if identityInt == 2 and Settings.twoUnlocked == true:
		activated = true
	if identityInt == 3 and Settings.threeUnlocked == true:
		activated = true
	if activated:
		if identityInt == 2:
			$Help.text = "this pillar has already\nbeen activated, search the world and find the other two"
		else:
			$Help.text = "this pillar has already\nuse *Warp To Hub* in pause menu to return"
		pass
	pass


func unlock():
	Settings.canUseGateways = true
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
	if sceneToLoad == "res://Levels/island_hub.tscn":
		teleport = false
	if teleport:
		main.load_new_scene(sceneToLoad)
	pass


func _on_player_near_area_body_entered(body):
	$Help.visible = true
	pass # Replace with function body.


func _on_player_near_area_body_exited(body):
	$Help.visible = false
	pass # Replace with function body.
