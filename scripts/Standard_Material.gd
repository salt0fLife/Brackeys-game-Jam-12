extends StaticBody3D
@export var health := 5
@export var item := [-1, "empty Item", "", 0, 0]
@export var dropMin := 1
@export var dropMax := 2


func take_damage(amount, type):
	if type == 2:
		if health - amount > 0:
			$AnimationPlayer.play("takeDamage")
			health -= amount
		else:
			die()
	pass

func die():
	var player = get_tree().get_nodes_in_group("Player")[0]
	var itemData = [item[0], item[1], item[2], randi_range(dropMin, dropMax), item[3]]
	player.pickup_item(itemData)
	queue_free()
	pass
