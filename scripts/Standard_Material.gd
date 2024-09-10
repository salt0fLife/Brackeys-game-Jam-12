extends StaticBody3D
@export var health := 5
@export var item := [-1, "empty Item", "", 0, 0]
@export var dropMin := 1
@export var dropMax := 2
@onready var hitpoints = health

func take_damage(amount, type, _knockback):
	if type == 2:
		if hitpoints - amount > 0:
			$AnimationPlayer.play("takeDamage")
			hitpoints -= amount
		else:
			die()
	pass

func die():
	hitpoints = health
	var player = get_tree().get_nodes_in_group("Player")[0]
	var itemData = [item[0], item[1], item[2], randi_range(dropMin, dropMax), item[3]]
	player.pickup_item(itemData)
	visible = false
	process_mode = Node.PROCESS_MODE_DISABLED
	await get_tree().create_timer(30).timeout
	process_mode = Node.PROCESS_MODE_INHERIT
	visible = true
	pass
