extends Node3D


# Called when the node enters the scene tree for the first time.
func _ready():
	if !Settings.hasUsedBow:
		$Label.visible = true
	pass # Replace with function body.
