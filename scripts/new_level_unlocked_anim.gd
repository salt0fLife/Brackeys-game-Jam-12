extends Node3D
var CanOpen = false

# Called when the node enters the scene tree for the first time.
func _ready():
	#checks to see if gate should open
	CanOpen = false
	if Settings.oneUnlocked and Settings.twoUnlocked and Settings.threeUnlocked:
		CanOpen = true
	showOffAnim()
	pass # Replace with function body.

func showOffAnim():
	#if Settings.oneUnlocked:
		#$Label.text += ", one unlocked"
	#if Settings.twoUnlocked:
		#$Label.text += ", two unlocked"
	#if Settings.threeUnlocked:
		#$Label.text += ", three unlocked"
	#
	$AnimationPlayer.play("showOffCurrentGate")
	await get_tree().create_timer(5).timeout
	
	if CanOpen:
		openGateAnim()
	else:
		toMain()
		pass
	pass

func openGateAnim():
	#$Label.hide()
	$Label2.visible = true
	$AnimationPlayer.play("unlockWholeGate")
	await get_tree().create_timer(7).timeout
	toMain()
	pass

func toMain():
	var main = get_tree().get_first_node_in_group("Main")
	main.load_new_scene("res://Levels/island_hub.tscn")
	pass
