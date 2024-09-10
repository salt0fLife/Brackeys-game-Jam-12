extends Node

#actual settings
var mouseSensitivity = 2.5
var debugMode = false
var fullscreen = false

#player stats
var playerSpeed = 10.0
var playerJump = 4.5

#levelHandling
const mainLevel = "res://Levels/island_hub.tscn"


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
