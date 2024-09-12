extends Node

#actual settings
var mouseSensitivity = 2.5
var debugMode = false
var fullscreen = false

#player stats
var playerSpeed = 5.0
var playerJump = 4.5
var playerHealth = 100.0
var currentHealth = 100.0

#levelHandling
const mainLevel = "res://Levels/island_hub.tscn"

#chest saving
var chests = [0, 0, 0, 0, 0, 0]
var spokeToStanford = false
var canUseGateways = false
var toutorial = true
var hasMined = false
var hasOpenedInventory = false
var hasChopped = false

var soundEffects = 50

func check_for_toutorial_completion():
	if hasMined and canUseGateways and spokeToStanford and hasOpenedInventory:
		toutorial = false
	pass


func set_mouseSensitivity(newVal):
	mouseSensitivity = newVal

func set_fullscreen(data):
	if data == true:
		fullscreen = true
		get_window().mode = Window.MODE_EXCLUSIVE_FULLSCREEN
	else:
		fullscreen = false
		get_window().mode = Window.MODE_WINDOWED
	pass

#three of the storm
var oneUnlocked = false
var twoUnlocked = false
var threeUnlocked = false

func unlockGatePart(num):
	if num == 1:
		oneUnlocked = true
	elif num == 2:
		twoUnlocked = true
	else:
		threeUnlocked = true
