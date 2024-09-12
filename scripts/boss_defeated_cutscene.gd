extends Node3D


# Called when the node enters the scene tree for the first time.
func _ready():
	$AnimationPlayer.play("Outro")
	await get_tree().create_timer(5).timeout
	var main = get_tree().get_first_node_in_group("Main")
	main.load_new_scene("res://Environment/Cutscenes/credits.tscn")

