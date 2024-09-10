extends CharacterBody3D
#attributes = [jump strength, max health, damage, speed]
var jumpTimer = 1.0
var jumpStrenth = 4
var maxHealth = 6
var damage = 5
var speed = 0.1


var SPEED = 5.0
var JUMP_VELOCITY = 4.5
@onready var player = get_tree().get_first_node_in_group("Player")


# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

func take_damage(amount, type = -1, knockback = Vector3(0,0,0)):
	velocity.x += knockback.x
	velocity.y += knockback.y
	velocity.z += knockback.z
	pass

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y -= gravity * delta
	else:
		velocity.x = velocity.x / 2
		velocity.z = velocity.z / 2
	
	if jumpTimer > 0:
		jumpTimer -= delta
	else:
		if is_on_floor():
			var target = player.global_position
			var current = global_position
			velocity.y = jumpStrenth
			jumpTimer = randi_range(5, 10) * speed
			velocity.x = current.x - target.x
			velocity.z = current.z - target.z
			#normalizes vectors
			velocity.x = -(velocity.x / abs(velocity.x)) * jumpStrenth
			velocity.z = -(velocity.z / abs(velocity.z)) * jumpStrenth
	move_and_slide()

