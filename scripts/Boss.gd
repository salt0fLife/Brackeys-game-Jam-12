extends CharacterBody3D
var health = 10
var dead = false

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

var energyBall = preload("res://creatures/projectiles/energy_ball.tscn")
var hasEyes = false

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
	if type == 2:
		amount = amount * 2
	
	if health - amount > 0:
		health -= amount
		$damagePillar/AnimationPlayer.play("takeDamage")
	else:
		if !dead:
			$damagePillar/AnimationPlayer.play("activate")
		dead = true
		
		pass
	pass

func shoot_energy_sphere():
	$damagePillar/AnimationPlayer.play("shoot")
	await get_tree().create_timer(0.5).timeout
	var es = energyBall.instantiate()
	var target_pos = get_tree().get_first_node_in_group("Player").global_position
	var offset = target_pos - global_position + Vector3(0, 2, 0)
	#normalize offset and apply speed
	var projectileSpeed = 20
	offset = offset * Vector3(0.2, 0.2, 0.2)
	#offset.x = offset.x/abs(offset.x) * projectileSpeed
	#offset.z = offset.z/abs(offset.z) * projectileSpeed
	#offset.y = offset.y/abs(offset.y) * projectileSpeed
	$projectileHandler.add_child(es)
	es.set_velocity(offset)
	es.position = global_position + Vector3(0, 2, 0)
	pass


func _on_timer_timeout():
	#print("timout")
	if !dead and hasEyes:
		shoot_energy_sphere()
	pass # Replace with function body.


func _on_attack_area_body_entered(body):
	hasEyes = true
	if !dead:
		shoot_energy_sphere()
	pass # Replace with function body.


func _on_attack_area_body_exited(body):
	hasEyes = false
	pass # Replace with function body.
