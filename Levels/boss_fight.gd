extends Node3D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$rot1.rotation.y += delta/10
	$rot3.rotation.y -= delta/15
	$rot4.rotation.y += delta/20
	pass
