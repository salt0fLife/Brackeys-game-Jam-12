extends CharacterBody3D
var health = 100


# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

var energyBall = preload("res://creatures/projectiles/energy_ball.tscn")

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y -= gravity * delta
	move_and_slide()

func alert_to_punish():
	var player = get_tree().get_first_node_in_group("Player")
	print("punished player")
	player.die()
	pass

func take_damage(amount, type, kb):
	
	
	pass

func shoot_energy_sphere():
	var es = energyBall.instantiate()
	var target_pos = get_tree().get_first_node_in_group("Player").global_position
	var offset = target_pos - global_position
	#normalize offset and apply speed
	var projectileSpeed = 20
	offset = offset * Vector3(0.2, 0.2, 0.2)
	#offset.x = offset.x/abs(offset.x) * projectileSpeed
	#offset.z = offset.z/abs(offset.z) * projectileSpeed
	#offset.y = offset.y/abs(offset.y) * projectileSpeed
	$projectileHandler.add_child(es)
	es.set_velocity(offset)
	es.position = global_position
	pass


func _on_timer_timeout():
	#print("timout")
	shoot_energy_sphere()
	pass # Replace with function body.
