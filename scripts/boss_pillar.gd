extends StaticBody3D
var explosion = preload("res://effects/particles/death_smoke.tscn")
var exploded = false
var health = 10
@export var debug := false

func take_damage(amount, type, kb):
	if type == 2 and health != -1:
		if health - amount <= 0:
			if !exploded:
				explode()
			health = -1
		else:
			$bossPillar/AnimationPlayer.play("takeDamage")
			health -= amount
	pass

func explode():
	$bossPillar/AnimationPlayer.play("activate")
	exploded = true
	if !debug:
		$"../..".pillarsGot += 1
		$"../..".check_for_completion()
	else:
		print("pillarsGot += 1")
		print("checking for completion")
	$MeshInstance3D4.hide()
	var boss = get_tree().get_first_node_in_group("Boss")
	add_child(explosion.instantiate())
	pass
