extends Node

#actual settings
var mouseSensitivity = 2.5

#player stats
var playerSpeed = 10.0
var playerJump = 4.5

#levelHandling
const mainLevel = "res://Levels/debug_level.tscn"


func set_mouseSensitivity(newVal):
	mouseSensitivity = newVal


