extends CharacterBody3D

#general
var SPEED = Settings.playerSpeed
var JUMP_VELOCITY = Settings.playerJump
var MouseSensitivity = Settings.mouseSensitivity
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

#items and combat
var HeldItem = 1 # 1 = sword, 2 = paxel, 3 = bow

#node paths
@onready var CameraHandler = $Graphics/CameraHandler
@onready var graphics = $Graphics

func update_values_from_settings():
	SPEED = Settings.playerSpeed
	JUMP_VELOCITY = Settings.playerJump
	MouseSensitivity = Settings.mouseSensitivity
	pass

func _ready():
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	pass


func _input(event):
	if event is InputEventMouseMotion and is_multiplayer_authority():
		var TempRotation = rotation.x - event.relative.y /1000 * MouseSensitivity
		CameraHandler.rotation.x += TempRotation
		CameraHandler.rotation.x = clamp(CameraHandler.rotation.x, -1.5, 1.5)
		graphics.rotation.y -= event.relative.x /1000 * MouseSensitivity
	pass


func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y -= gravity * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir = Input.get_vector("left", "right", "up", "down")
	var direction = (graphics.transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)

	move_and_slide()
