extends Node3D
var pillarsGot = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$rot1.rotation.y += delta/10
	$rot3.rotation.y -= delta/15
	$rot4.rotation.y += delta/20
	pass

func check_for_completion():
	if pillarsGot >= 4:
		killBoss()
		pass
	pass

func killBoss():
	var main = get_tree().get_first_node_in_group("Main")
	main.load_new_scene("res://Environment/Cutscenes/boss_defeated_cutscene.tscn")
	pass
