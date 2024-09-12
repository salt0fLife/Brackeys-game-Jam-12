extends StaticBody3D
var explosion = preload("res://effects/particles/death_smoke.tscn")
var exploded = false

func take_damage(amount, type, kb):
	if !exploded:
		explode()
	
	pass

func explode():
	exploded = true
	$"../..".pillarsGot += 1
	$"../..".check_for_completion()
	$MeshInstance3D4.hide()
	var boss = get_tree().get_first_node_in_group("Boss")
	add_child(explosion.instantiate())
	pass
