extends CharacterBody3D
#local scene changes
@export var initialRotDegrees = 0


#general
var debugMode = Settings.debugMode
var MaxSPEED = Settings.playerSpeed
var MaxJUMP_VELOCITY = Settings.playerJump
var MouseSensitivity = Settings.mouseSensitivity
var HealthDefault = Settings.playerHealth
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")
var disabled = false
var inInventory = false

var SPEED = MaxSPEED
var JUMP_VELOCITY = MaxJUMP_VELOCITY
var maxHealth = HealthDefault
var health = maxHealth

var regenCooldownTimer = 0


#items and combat
var bufferedInput = ""
var actionState = false

var HeldItem = ItemHandler.HeldItem # 1 = sword, 2 = paxel, 3 = bow

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
@onready var localWeaponsInv = ItemHandler.weaponsInv
var selectedWeaponIndex = -1
var bufferingUse = false

#node paths
@onready var CameraHandler = $Graphics/CameraHandler
@onready var graphics = $Graphics
@onready var ItemGraphicsHandler = $Graphics/CameraHandler/ItemGraphicsHandler
@onready var chRay = $Graphics/CameraHandler/CrosshairRay
@onready var inventoryList = $inventoryList
@onready var BowRay = $Graphics/CameraHandler/CrossBowRay


#preloads (arrows particles and such)
@onready var hitMarker = preload("res://effects/particles/damage_indicator.tscn")
@onready var arrow = preload("res://effects/particles/stuck_arrow.tscn")

func update_stats_from_item_tags():
	SPEED = MaxSPEED
	JUMP_VELOCITY = MaxJUMP_VELOCITY
	maxHealth = HealthDefault
	var swordTags = swordInfo[4]
	var paxelTags = paxelInfo[4]
	var bowTags = bowInfo[4]
	
	for tag in swordTags:
		if tag == "speedy":
			SPEED = SPEED * 1.5
			pass
		if tag == "lightFooted":
			JUMP_VELOCITY = JUMP_VELOCITY * 1.5
		if tag == "healthy":
			maxHealth = maxHealth * 1.5
	pass

func set_disabled(data = true):
	disabled = data

func update_values_from_settings():
	SPEED = Settings.playerSpeed
	JUMP_VELOCITY = Settings.playerJump
	MouseSensitivity = Settings.mouseSensitivity
	debugMode = Settings.debugMode
	pass

func _ready():
	graphics.rotation_degrees.y = initialRotDegrees
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	update_heldItem_graphics()
	update_Inventory_graphics()
	update_stats_from_item_tags()
	health = maxHealth
	update_health_graphics()
	pass

func use_item():
	#print("used item of int " + str(HeldItem))
	if HeldItem == 1:
		use_sword()
	elif HeldItem == 2:
		use_paxel()
	else:
		use_bow()
	pass

func heavy_use_item():
	#printerr("cannot use item of int " + str(HeldItem) + " as heavy item")
	if HeldItem == 1:
		sword_special_attack()
		pass
	elif HeldItem == 2:
		use_paxel()
		pass
	else:
		toggle_bow_aim()
	pass

func sword_special_attack():
	var swordTags = swordInfo[4]
	for tag in swordTags:
		if tag == "vanilla":
			sword_heavy_attack()
			return
		elif tag == "leaping":
			sword_leaping_attack()
			return
		else:
			actionState = false
	pass

func sword_heavy_attack():
	var itemGraphics = ItemGraphicsHandler.get_child(0, false)
	itemGraphics.get_child(0, true).play("Attack3")
	actionState = true
	var damage = swordInfo[2] * 2
	check_for_hit(damage)
	await get_tree().create_timer(0.75).timeout
	if bufferedInput == "UseItem":
		bufferedInput = ""
		use_sword()
	else:
		bufferedInput = ""
		actionState = false
		itemGraphics.get_child(0, true).play("idle")
	pass

func sword_leaping_attack():
	velocity.y = JUMP_VELOCITY*3
	velocity.x = velocity.x * 3
	velocity.z = velocity.z * 3
	printerr("sword leaping attack not fully implemented")
	pass

func toggle_bow_aim():
	printerr("bow aiming not implemented")
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
	elif bufferedInput == "HeavyUseItem":
		bufferedInput = ""
		sword_special_attack()
	else:
		bufferedInput = ""
		actionState = false
		itemGraphics.get_child(0, true).play("idle")
	pass

func sword_attack_2():
	#print("sword attack 2")
	var itemGraphics = ItemGraphicsHandler.get_child(0, false)
	itemGraphics.get_child(0, true).play("Attack2")
	check_for_hit()
	await get_tree().create_timer(0.5).timeout
	if bufferedInput == "UseItem":
		bufferedInput = ""
		sword_attack_3()
	elif bufferedInput == "HeavyUseItem":
		bufferedInput = ""
		sword_special_attack()
		pass
	else:
		bufferedInput = ""
		actionState = false
		itemGraphics.get_child(0, true).play("idle")
	pass

func sword_attack_3():
	#print("sword attack 3")
	var itemGraphics = ItemGraphicsHandler.get_child(0, false)
	itemGraphics.get_child(0, true).play("Attack3")
	check_for_hit()
	await get_tree().create_timer(0.5).timeout
	if bufferedInput == "UseItem":
		bufferedInput = ""
		use_sword()
	elif bufferedInput == "HeavyUseItem":
		bufferedInput = ""
		sword_special_attack()
		pass
	else:
		bufferedInput = ""
		actionState = false
		itemGraphics.get_child(0, true).play("idle")
	pass

func use_paxel():
	actionState = true
	var itemGraphics = ItemGraphicsHandler.get_child(0, false)
	itemGraphics.get_child(0, true).play("use")
	await get_tree().create_timer(0.51).timeout
	check_for_hit()
	actionState = false
	itemGraphics.get_child(0, true).play("idle")
	pass

func use_bow():
	actionState = true
	var itemGraphics = ItemGraphicsHandler.get_child(0, false)
	itemGraphics.get_child(0, true).play("shoot")
	if BowRay.is_colliding():
		var poi = BowRay.get_collision_point()
		var hit = BowRay.get_collider()
		if hit.has_method("take_damage") and hit != self:
			var knockback = bowInfo[3]
			var damage = bowInfo[2]
			var kbVector = global_position - poi
			kbVector.x = -(kbVector.x / abs(kbVector.x)) * knockback
			kbVector.y = -(kbVector.y / abs(kbVector.y)) * knockback
			kbVector.z = -(kbVector.z / abs(kbVector.z)) * knockback
			
			hit.take_damage(knockback, 3, kbVector)
			
			var arGraphic = arrow.instantiate()
			hit.add_child(arGraphic)
			arGraphic.global_rotation = CameraHandler.global_rotation
			arGraphic.global_position = poi
			
			var hm = hitMarker.instantiate()
			hm.set_value(damage)
			hit.add_child(hm)
			hm.global_position = poi
			pass
	await get_tree().create_timer(1).timeout
	actionState = false
	itemGraphics.get_child(0, true).play("idle")
	
	
	#printerr("bow not implemented")
	pass

func check_for_hit(damage = swordInfo[2], crit = false):
	if HeldItem == 1:
		if chRay.is_colliding():
			var poi = chRay.get_collision_point()
			var hit = chRay.get_collider()
			deal_damage(damage, hit, poi, false)
		elif $Graphics/CameraHandler/CrosshairRay2.is_colliding():
			var poi = $Graphics/CameraHandler/CrosshairRay2.get_collision_point()
			var hit = $Graphics/CameraHandler/CrosshairRay2.get_collider()
			deal_damage(damage, hit, poi, false)
		elif $Graphics/CameraHandler/CrosshairRay3.is_colliding():
			var poi = $Graphics/CameraHandler/CrosshairRay3.get_collision_point()
			var hit = $Graphics/CameraHandler/CrosshairRay3.get_collider()
			deal_damage(damage, hit, poi, false)
	elif HeldItem == 2:
		if chRay.is_colliding():
			var hit = chRay.get_collider()
			if hit.has_method("take_damage") and hit != self:
				hit.take_damage(paxelInfo[2], 2, Vector3(0,0,0))
				pass
	else:
		printerr("bow does not deal damage like this")
	pass

func deal_damage(damage, hit, poi, crit = false):
	if hit.has_method("take_damage") and hit != self:
		var knockback = 3
		for tag in swordInfo[4]:
			if tag == "critical":
				crit = true
			if tag == "heavyHanded":
				knockback = knockback * 2
			if tag == "flaming":
				printerr("flaming not implemented yet")
			pass
		if randi_range(1, 10) == 10:
			crit = true
		if crit:
			damage = damage * 2
		
		#knockback vector
		var kbVector = global_position - poi
		kbVector.x = -(kbVector.x / abs(kbVector.x)) * knockback
		kbVector.y = -(kbVector.y / abs(kbVector.y)) * knockback
		kbVector.z = -(kbVector.z / abs(kbVector.z)) * knockback
		
		hit.take_damage(damage, 1, kbVector)
		var hm = hitMarker.instantiate()
		hm.set_value(damage)
		hit.add_child(hm)
		hm.global_position = poi
		pass
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
	#cannot be disabled
	####################
	if Input.is_action_just_pressed("inventory"):
		#pickup_item([0, "twig", "twig", 1, 2])
		if inInventory:
			close_inventory()
		else:
			open_inventory()
		pass
	
	####################
	if disabled:
		return
	
	if Input.is_action_just_pressed("sword"):
		if HeldItem != 1:
			if actionState:
				bufferedInput = "sword"
			else:
				HeldItem = 1
				sync_HeldItem()
				update_heldItem_graphics()
	if Input.is_action_just_pressed("paxel"):
		if HeldItem != 2:
			if actionState:
				bufferedInput = "paxel"
			else:
				HeldItem = 2
				sync_HeldItem()
				update_heldItem_graphics()
	if Input.is_action_just_pressed("bow"):
		if HeldItem != 3:
			if actionState:
				bufferedInput = "bow"
			else:
				HeldItem = 3
				sync_HeldItem()
				update_heldItem_graphics()
	
	if Input.is_action_just_pressed("UseItem"):
		bufferingUse = true
		if !actionState:
			use_item()
		else:
			bufferedInput = "UseItem"
	if Input.is_action_just_released("UseItem"):
		bufferingUse = false
		pass
	if Input.is_action_just_pressed("HeavyUseItem"):
		if !actionState:
			heavy_use_item()
		else:
			bufferedInput = "HeavyUseItem"
	if Input.is_action_just_pressed("interact"):
		attempt_interact()
		pass
	
	
	if event is InputEventMouseMotion and is_multiplayer_authority():
		var TempRotation = rotation.x - event.relative.y /1000 * MouseSensitivity
		CameraHandler.rotation.x += TempRotation
		CameraHandler.rotation.x = clamp(CameraHandler.rotation.x, -1.5, 1.5)
		graphics.rotation.y -= event.relative.x /1000 * MouseSensitivity
	pass

func open_inventory():
	for shop in get_tree().get_nodes_in_group("ShopKeeper"):
		shop.close_shop()
	update_Inventory_graphics()
	disabled = true
	inInventory = true
	$Inventory.visible = true
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	pass

func close_inventory():
	inInventory = false
	$Inventory.visible = false
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	disabled = false
	pass

func attempt_interact():
	if chRay.is_colliding():
		var hit = chRay.get_collider()
		if hit.has_method("interact"):
			hit.interact()

func sync_HeldItem():
	ItemHandler.set_HeldItem(HeldItem)

func _physics_process(delta):
	#check for void plane
	if position.y <= -25:
		die()
	
	# Add the gravity.
	if not is_on_floor():
		velocity.y -= gravity * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor() and !disabled:
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir = Input.get_vector("left", "right", "up", "down")
	var direction = (graphics.transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if disabled:
		direction = Vector3(0,0,0)
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	elif is_on_floor():
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)

	move_and_slide()

func pickup_item(itemData = [-1]):
	if itemData[0] == 0:
		var Reference = itemData[1]
		var stacked = false
		for item in localInv:
			if item[1] == Reference:
				item[3] += itemData[3]
				stacked = true
				push_inventory_changes()
				update_Inventory_graphics()
				return
		if !stacked:
			localInv += [itemData]
		push_inventory_changes()
		update_Inventory_graphics()
	else:
		localWeaponsInv += [itemData]
		push_inventory_changes()
		update_Inventory_graphics()
		pass
	pass

func push_inventory_changes():
	ItemHandler.inventory = localInv
	ItemHandler.equippedSword = swordInfo
	ItemHandler.equippedpaxel = paxelInfo
	ItemHandler.equippedBow = bowInfo
	ItemHandler.weaponsInv = localWeaponsInv

func update_Inventory_graphics():
	inventoryList.text = ""
	for item in localInv:
		inventoryList.text += item[1] + " : " + str(item[3]) + "\n"
		pass
	
	$Inventory/currentWeapons/SwordInfo.text = str(swordInfo)
	$Inventory/currentWeapons/PaxelInfo.text = str(paxelInfo)
	$Inventory/currentWeapons/BowInfo.text = str(bowInfo)
	
	for b in $Inventory/avalableWeapons.get_children(false):
		b.queue_free()
	for i in localWeaponsInv.size():
		var but = Button.new()
		but.text = localWeaponsInv[i][1]
		but.pressed.connect(_on_weapon_button_pressed.bind(i))
		$Inventory/avalableWeapons.add_child(but)
	
	if selectedWeaponIndex != -1:
		$Inventory/SelectedWeaponInfo/WeaponInfo.text = str(localWeaponsInv[selectedWeaponIndex])
		pass

func _on_weapon_button_pressed(Index = -1):
	if selectedWeaponIndex != Index:
		selectedWeaponIndex = Index
		update_Inventory_graphics()
	pass

func die():
	position = Vector3(0,0,0)
	health = maxHealth
	update_health_graphics()
	pass

func die_boss():
	
	pass

func _on_equip_selected_weapon_button_down():
	if selectedWeaponIndex >= localWeaponsInv.size():
		selectedWeaponIndex = -1
		printerr("ERROR: cannot equip item : invalid selectedWeaponIndex")
	
	if selectedWeaponIndex != -1:
		var weaponinQuestion = localWeaponsInv[selectedWeaponIndex]
		if weaponinQuestion[0] == 1:
			var temp = swordInfo
			swordInfo = weaponinQuestion
			localWeaponsInv[selectedWeaponIndex] = temp
			push_inventory_changes()
			update_Inventory_graphics()
			update_heldItem_graphics()
			update_stats_from_item_tags()
			pass
		elif weaponinQuestion[0] == 2:
			var temp = paxelInfo
			paxelInfo = weaponinQuestion
			localWeaponsInv[selectedWeaponIndex] = temp
			push_inventory_changes()
			update_Inventory_graphics()
			update_heldItem_graphics()
			update_stats_from_item_tags()
			pass
		elif weaponinQuestion[0] == 3:
			var temp = bowInfo
			bowInfo = weaponinQuestion
			localWeaponsInv[selectedWeaponIndex] = temp
			push_inventory_changes()
			update_Inventory_graphics()
			update_heldItem_graphics()
			update_stats_from_item_tags()
			pass
		else:
			printerr("ERROR: cannot equip item of type " + str(weaponinQuestion[0]))
		
		pass
	pass # Replace with function body.

func _process(delta):
	if regenCooldownTimer > 0:
		regenCooldownTimer -= delta
	elif health != maxHealth:
		health += delta * 10
		if health > maxHealth:
			health = maxHealth
		update_health_graphics()
	
	if bufferingUse:
		if HeldItem == 2:
			if !actionState:
				use_paxel()
		bufferedInput = "UseItem"
	pass

func update_health_graphics():
	$HUD/healthDisplay.text = str(health)
	pass

func take_damage(amount, tag, knockback):
	if health - amount > 0:
		health -= amount
		regenCooldownTimer = 5.0
		$screenOverlay/damageAnimations.play("take_damage")
		update_health_graphics()
		pass
	else:
		die()
	pass
