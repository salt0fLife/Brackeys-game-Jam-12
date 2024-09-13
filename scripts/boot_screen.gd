extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	$AnimationPlayer.play("intro")
	await get_tree().create_timer(4).timeout
	get_tree().change_scene_to_file("res://main.tscn")
