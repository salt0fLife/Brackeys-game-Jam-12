extends CharacterBody3D

#general
var SPEED = Settings.playerSpeed
var JUMP_VELOCITY = Settings.playerJump
var MouseSensitivity = Settings.mouseSensitivity
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

#items and combat
var bufferedInput = ""
var actionState = false

var HeldItem = 1 # 1 = sword, 2 = paxel, 3 = bow

#sword
#info = [identityINT, name, damage, heavy attack type, [tags], 3dFilePath, 2dFilePath]
var swordInfo = ItemHandler.equippedSword

#paxel
#info = [identityINT, name, mining power, ability type, [tags], 3dFilePath, 2dFilePath]
var paxelInfo = ItemHandler.equippedpaxel

#bow
#info = [identityINT, name, damage, drawSpeed, [tags], 3dFilePath, 2dFilePath]
var bowInfo = ItemHandler.equippedBow

#inventory
@onready var localInv = ItemHandler.inventory


#node paths
@onready var CameraHandler = $Graphics/CameraHandler
@onready var graphics = $Graphics
@onready var ItemGraphicsHandler = $Graphics/CameraHandler/ItemGraphicsHandler
@onready var chRay = $Graphics/CameraHandler/CrosshairRay
@onready var inventoryList = $Inventory/inventoryList


#preloads (arrows particles and such)
@onready var hitMarker = preload("res://effects/particles/damage_indicator.tscn")

func update_values_from_settings():
	SPEED = Settings.playerSpeed
	JUMP_VELOCITY = Settings.playerJump
	MouseSensitivity = Settings.mouseSensitivity
	pass

func _ready():
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	update_heldItem_graphics()
	update_Inventory_graphics()
	pass

func use_item():
	print("used item of int " + str(HeldItem))
	if HeldItem == 1:
		use_sword()
	elif HeldItem == 2:
		use_paxel()
	else:
		use_bow()
	pass

func heavy_use_item():
	printerr("cannot use item of int " + str(HeldItem) + " as heavy item")
	pass

func use_sword():
	var itemGraphics = ItemGraphicsHandler.get_child(0, false)
	itemGraphics.get_child(0, true).play("Attack1")
	actionState = true
	check_for_hit()
	await get_tree().create_timer(0.5).timeout
	if bufferedInput == "UseItem":
		bufferedInput = ""
		sword_attack_2()
	else:
		bufferedInput = ""
		actionState = false
		itemGraphics.get_child(0, true).play("idle")
	pass

func sword_attack_2():
	print("sword attack 2")
	var itemGraphics = ItemGraphicsHandler.get_child(0, false)
	itemGraphics.get_child(0, true).play("Attack2")
	check_for_hit()
	await get_tree().create_timer(0.5).timeout
	if bufferedInput == "UseItem":
		bufferedInput = ""
		sword_attack_3()
	else:
		bufferedInput = ""
		actionState = false
		itemGraphics.get_child(0, true).play("idle")
	pass

func sword_attack_3():
	print("sword attack 3")
	var itemGraphics = ItemGraphicsHandler.get_child(0, false)
	itemGraphics.get_child(0, true).play("Attack3")
	check_for_hit()
	await get_tree().create_timer(0.5).timeout
	bufferedInput = ""
	actionState = false
	itemGraphics.get_child(0, true).play("idle")
	pass

func use_paxel():
	actionState = true
	var itemGraphics = ItemGraphicsHandler.get_child(0, false)
	itemGraphics.get_child(0, true).play("use")
	check_for_hit()
	await get_tree().create_timer(0.51).timeout
	actionState = false
	itemGraphics.get_child(0, true).play("idle")
	pass

func use_bow():
	printerr("bow not implemented")
	pass

func check_for_hit():
	if HeldItem == 1:
		if chRay.is_colliding():
			var poi = chRay.get_collision_point()
			var hit = chRay.get_collider()
			if hit.has_method("take_damage") and hit != self:
				var damage = swordInfo[2]
				hit.take_damage(damage, 1)
				var hm = hitMarker.instantiate()
				hm.set_value(damage)
				hit.add_child(hm)
				hm.global_position = poi
				pass
	elif HeldItem == 2:
		if chRay.is_colliding():
			var hit = chRay.get_collider()
			if hit.has_method("take_damage") and hit != self:
				hit.take_damage(paxelInfo[2], 2)
				pass
	else:
		printerr("bow does not deal damage like this")
	pass

func update_heldItem_graphics():
	if ItemGraphicsHandler.get_child_count(false) > 0:
		for item in ItemGraphicsHandler.get_children(false):
			item.queue_free()
	if HeldItem == 1:
		var sword = load(swordInfo[5]).instantiate()
		ItemGraphicsHandler.add_child(sword)
		pass
	elif HeldItem == 2:
		var paxel = load(paxelInfo[5]).instantiate()
		ItemGraphicsHandler.add_child(paxel)
		pass
	elif HeldItem == 3:
		var bow = load(bowInfo[5]).instantiate()
		ItemGraphicsHandler.add_child(bow)
		pass

func _input(event):
	if Input.is_action_just_pressed("sword"):
		if HeldItem != 1:
			if actionState:
				bufferedInput = "sword"
			else:
				HeldItem = 1
				update_heldItem_graphics()
	if Input.is_action_just_pressed("paxel"):
		if HeldItem != 2:
			if actionState:
				bufferedInput = "paxel"
			else:
				HeldItem = 2
				update_heldItem_graphics()
	if Input.is_action_just_pressed("bow"):
		if HeldItem != 3:
			if actionState:
				bufferedInput = "bow"
			else:
				HeldItem = 3
				update_heldItem_graphics()
	
	if Input.is_action_just_pressed("UseItem"):
		if !actionState:
			use_item()
		else:
			bufferedInput = "UseItem"
	if Input.is_action_just_pressed("HeavyUseItem"):
		if !actionState:
			heavy_use_item()
		else:
			bufferedInput = "HeavyUseItem"
	if Input.is_action_just_pressed("inventory"):
		pickup_item([0, "twig", "twig", 1, 2])
		pass
	
	
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

func pickup_item(itemData = [-1]):
	if itemData[0] == 0:
		var Reference = itemData[2]
		var stacked = false
		for item in localInv:
			if item[2] == Reference:
				item[3] += itemData[3]
				stacked = true
				push_inventory_changes()
				update_Inventory_graphics()
				return
		if !stacked:
			localInv += [itemData]
		push_inventory_changes()
		update_Inventory_graphics()
	pass

func push_inventory_changes():
	ItemHandler.set_inventory(localInv)

func update_Inventory_graphics():
	inventoryList.text = ""
	for item in localInv:
		inventoryList.text += item[1] + " : " + str(item[3]) + "\n"
		pass
	pass
