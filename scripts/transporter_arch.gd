extends Node3D
@export var pathToLoad := ""





func _on_trigger_area_body_entered(body):
	var main = get_tree().get_nodes_in_group("Main")[0]
	main.load_new_scene(pathToLoad)
	
