extends CharacterBody3D



# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")


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
