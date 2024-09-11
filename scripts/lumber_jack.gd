extends Node3D
var shopOpen = false
var canInteract = true

const tooltip = "press R or Q to open shop"
#recipes
#[item to craft], [[required item, count], [different required item, count]]
#sword costs [handle, 1], [metal 10-20]
#emerald = lightFooted
#ruby = healthy
#magic sand = speed


var swordHandle = [[0, "Sword Handle", "swordHandle", 2], [["Oak Wood", 1], ["Birch Wood", 1]]]
#var healthySword = [[1, "sword of health", 3,0,["vanilla", "healthy", "sword"], "res://player/items/DefaultSword/default_sword.tscn"], [["swordHandle", 1], ["Iron Ore", 10], ["Copper Ore", 10], ["Ruby", 10]]]
#var SpeedySword = [[1, "sword of speed", 3,0,["vanilla", "speedy", "sword"], "res://player/items/DefaultSword/default_sword.tscn"], [["swordHandle", 1], ["Iron Ore", 10], ["Copper Ore", 10], ["Magic Sand", 10]]]
#var JumpSword = [[1, "sword of jump", 3,0,["vanilla", "lightFooted", "sword"], "res://player/items/DefaultSword/default_sword.tscn"], [["swordHandle", 1], ["Iron Ore", 10], ["Copper Ore", 10], ["Emerald", 10]]]
var fastHealthySword = [[1, "fast sword of health", 3,0,["speedy", "vanilla", "healthy", "healthy", "sword"], "res://player/items/DefaultSword/default_sword.tscn"], [["swordHandle", 1], ["Iron Ore", 10], ["Copper Ore", 10], ["Ruby", 10], ["Magic Sand", 5]]]
var fastJumpSword = [[1, "fast sword of jump", 3,0,["speedy", "vanilla", "lightFooted", "lightFooted", "sword"], "res://player/items/DefaultSword/default_sword.tscn"], [["swordHandle", 1], ["Iron Ore", 10], ["Copper Ore", 10], ["Emerald", 10], ["Magic Sand", 5]]]
var fastSpeedySword = [[1, "fast sword of speed", 3,0,["speedy", "speedy", "speedy", "vanilla", "sword"], "res://player/items/DefaultSword/default_sword.tscn"], [["swordHandle", 1], ["Iron Ore", 10], ["Copper Ore", 10], ["Magic Sand", 10], ["Magic Sand", 5]]]
var healthyHealthySword = [[1, "healthy sword of health", 3,0,["healthy", "vanilla", "healthy", "healthy", "sword"], "res://player/items/DefaultSword/default_sword.tscn"], [["swordHandle", 1], ["Iron Ore", 10], ["Copper Ore", 10], ["Ruby", 10], ["Ruby", 5]]]
var healthyJumpSword = [[1, "healthy sword of jump", 3,0,["healthy", "vanilla", "lightFooted", "lightFooted", "sword"], "res://player/items/DefaultSword/default_sword.tscn"], [["swordHandle", 1], ["Iron Ore", 10], ["Copper Ore", 10], ["Emerald", 10], ["Ruby", 5]]]
var healthySpeedySword = [[1, "healthy sword of speed", 3,0,["healthy", "speedy", "speedy", "vanilla", "sword"], "res://player/items/DefaultSword/default_sword.tscn"], [["swordHandle", 1], ["Iron Ore", 10], ["Copper Ore", 10], ["Magic Sand", 10], ["Ruby", 5]]]
var lightHealthySword = [[1, "light sword of health", 3,0,["lightFooted", "vanilla", "healthy", "healthy", "sword"], "res://player/items/DefaultSword/default_sword.tscn"], [["swordHandle", 1], ["Iron Ore", 10], ["Copper Ore", 10], ["Ruby", 10], ["Emerald", 5]]]
var lightJumpSword = [[1, "light sword of jump", 3,0,["lightFooted", "vanilla", "lightFooted", "lightFooted", "sword"], "res://player/items/DefaultSword/default_sword.tscn"], [["swordHandle", 1], ["Iron Ore", 10], ["Copper Ore", 10], ["Emerald", 10], ["Emerald", 5]]]
var lightSpeedySword = [[1, "light sword of speed", 3,0,["lightFooted", "speedy", "speedy", "vanilla", "sword"], "res://player/items/DefaultSword/default_sword.tscn"], [["swordHandle", 1], ["Iron Ore", 10], ["Copper Ore", 10], ["Magic Sand", 10], ["Emerald", 5]]]

var fastSuperiorBow = [[3, "fast superior Bow", 3,3,["vanilla", "bow", "speedy"], "res://player/items/DefaultBow/default_bow.tscn"], [["Oak Wood", 10], ["Birch Wood", 10], ["Magic Sand", 5]]]
var healthySuperiorBow = [[3, "healthy superior Bow", 3,3,["vanilla", "bow", "healthy"], "res://player/items/DefaultBow/default_bow.tscn"], [["Oak Wood", 10], ["Birch Wood", 10], ["Magic Sand", 5]]]
var lightSuperiorBow = [[3, "light superior Bow", 3,3,["vanilla", "bow", "lightFooted"], "res://player/items/DefaultBow/default_bow.tscn"], [["Oak Wood", 10], ["Birch Wood", 10], ["Magic Sand", 5]]]

var fastSuperiorpaxel = [[2, "fast superior paxel", 5,0,["vanilla", "paxel", "speedy"], "res://player/items/DefaultPaxel/default_paxel.tscn"], [["Oak Wood", 5], ["Birch Wood", 5], ["Iron Ore", 5], ["Copper Ore", 5], ["Magic Sand", 5]]]
var healthySuperiorpaxel = [[2, "healthy superior paxel", 5,0,["vanilla", "paxel", "healthy"], "res://player/items/DefaultPaxel/default_paxel.tscn"], [["Oak Wood", 5], ["Birch Wood", 5], ["Iron Ore", 5], ["Copper Ore", 5], ["Ruby", 5]]]
var lightSuperiorpaxel = [[2, "light superior paxel", 5,0,["vanilla", "paxel", "lightFooted"], "res://player/items/DefaultPaxel/default_paxel.tscn"], [["Oak Wood", 5], ["Birch Wood", 5], ["Iron Ore", 5], ["Copper Ore", 5], ["Emerald", 5]]]




var recipeIndex = -1

@onready var recipes = [swordHandle, fastSuperiorpaxel, healthySuperiorpaxel, lightSuperiorpaxel, fastSuperiorBow, healthySuperiorBow, lightSuperiorBow, fastHealthySword, fastJumpSword, fastSpeedySword, healthyHealthySword, healthyJumpSword, healthySpeedySword, lightHealthySword, lightJumpSword, lightSpeedySword]

#dialogue
var goodbyes = ["come back again soon!", "pleasant talking with you", "have a great rest of your day!", "hope it was helpfull", "anothertime then!", "goodluck on your adventure!", "see you around!", "LATER THEN!", "always appreciate the buisness!", "heard chests could be found in the mines", "there are some special weapons hidden\naround the world if you know\nwhere to look", "I dont mean to alarm you but I think were\n living in a simulation"]
var greetings = ["howdy, hows saving the world going?", "Hello traveler!", "care to buy anything?", "want to try some new weapons?", "open since 1945!", "come on down to \nthe lumberjack's shack!", "under new managment!\nnot really", "the only place to buy tools!", "no refunds or returns ever!", "got some materials to spend?"]


func _ready():
	$shop.hide()
	if !Settings.spokeToStanford:
		$nameTag.text = "hello! my name is Stanford!\ncare to buy anything?"
	else:
		var gi = randi_range(0, greetings.size()-1)
		$nameTag.text = greetings[gi]

func interact():
	canInteract = false
	if shopOpen:
		close_shop()
	else:
		open_shop()
	print("hello my name is stanford!")
	await get_tree().create_timer(0.5).timeout
	canInteract = true
	pass

func open_shop():
	$nameTag.hide()
	update_inventory_display()
	Settings.spokeToStanford = true
	populate_shop()
	var player = get_tree().get_first_node_in_group("Player")
	player.set_disabled(true)
	shopOpen = true
	$shop.visible = true
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	pass

func close_shop():
	var gi = randi_range(0, goodbyes.size()-1)
	$nameTag.text = goodbyes[gi]
	$nameTag.visible = true
	
	var player = get_tree().get_first_node_in_group("Player")
	player.set_disabled(false)
	$shop.visible = false
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	shopOpen = false
	pass

func _input(event):
	if Input.is_action_just_pressed("closeDialogue"):
		if $shop.visible == true:
			close_shop()
	if Input.is_action_just_pressed("pause"):
		close_shop()
	pass

func populate_shop():
	for b in $shop/shopButtons/ItemsForSale/VBoxContainer.get_children(false):
		b.queue_free()
	
	for i in recipes.size():
		var but = Button.new()
		but.text = recipes[i][0][1]
		but.pressed.connect(_on_recipe_selected.bind(i))
		$shop/shopButtons/ItemsForSale/VBoxContainer.add_child(but)
	pass

func _on_recipe_selected(index = -1):
	if index == -1 or index > recipes.size()-1:
		$shop/shopButtons/selectedRecipe/selectedRecipeDisplay.text = ""
		printerr("warning attempted updating with invalid index")
	else:
		var shopText = str(recipes[index])
		
		recipeIndex = index
		if recipes[index][0][0] == 0:
			#crafting ingredient
			shopText = "Item to Craft\nType : " + recipes[index][0][1] + "\nAmount : " + str(recipes[index][0][3]) + "\nRequired items:"
			for i in recipes[index][1]:
				shopText += "\n" + str(i[1]) + " " + i[0] + "'s"
				pass
			if check_to_craft():
				shopText += "\nYou Can Afford This"
				pass
			else:
				shopText += "\nYou do NOT have the necessary ingredients"
				shopText += "\ngather more materials using your paxel (key *2*)"
			
			pass
		else:
			#tool
			shopText = "Item to Craft\nName : " + recipes[index][0][1]
			shopText += "\nthis items uniqueTags are : "
			for tag in recipes[index][0][4]:
				shopText += "\n" + tag
				pass
			shopText += "\n\nRequired items:"
			for i in recipes[index][1]:
				shopText += "\n" + str(i[1]) + " " + i[0] + "'s"
				pass
			if check_to_craft():
				shopText += "\n\nYou Can Afford This"
				pass
			else:
				shopText += "\n\nYou do NOT have the necessary ingredients"
				shopText += "\ngather more materials using your paxel (key *2*)"
			pass
		$shop/shopButtons/selectedRecipe/selectedRecipeDisplay.text = shopText
		pass
	pass

func update_inventory_display():
	$shop/shopButtons/playerItems.text = ""
	for item in ItemHandler.inventory:
		if item[3] != 0:
			$shop/shopButtons/playerItems.text += item[1] + " : " + str(item[3]) + "\n"

func _on_close_shop_button_down():
	close_shop()

func _on_craft_button_down():
	if check_to_craft():
		craft(recipeIndex)
	else:
		cant_craft(recipeIndex)
	pass

func check_to_craft():
	if recipeIndex == -1 or recipeIndex > recipes.size()-1:
		print("-1")
		cant_craft()
		return
	var canCraft = true
	var recipe = recipes[recipeIndex]
	var ingredients = recipe[1]
	for Iindex in ingredients:
		var keyword = Iindex[0]
		var last = ItemHandler.inventory[ItemHandler.inventory.size()-1]
		
		#checks inventory for ingredient
		var gottem = false
		for Pindex in ItemHandler.inventory:
			#checking inventory for ingredient
			if Pindex[2] == keyword:
				if Pindex[3] - Iindex[1] >= 0:
					#has enough of ingredient
					gottem = true
					pass
				else:
					#does not have enough of ingredient
					#print("found ingredient but didnt have enough")
					canCraft = false
			elif Pindex[1] == last[1] and !gottem:
				#did not have ingredient at all
				#print("could not find an ingredient")
				canCraft = false
			pass
		pass
	if canCraft:
		return true
		#craft(recipeIndex)
	else:
		return false
		#cant_craft(recipeIndex)
	return false

func cant_craft(index = -1):
	print("cant craft " + str(index))
	pass

func craft(index):
	var player = get_tree().get_first_node_in_group("Player")
	#print("crafting index " + str(index) + "!")
	var recipe = recipes[index]
	#takeItems
	for ingredient in recipe[1]:
		for item in player.localInv:
			if item[2] == ingredient[0]:
				item[3] -= ingredient[1]
			pass
		pass
	var crafted = recipe[0]
	player.pickup_item(crafted)
	if crafted[1] != "Sword Handle":
		recipes.remove_at(index)
	var craftedName = crafted[1]
	$Label.text = craftedName + " added to inventory"
	$Label.visible = true
	populate_shop()
	update_inventory_display()
	_on_recipe_selected(recipeIndex)
	await get_tree().create_timer(1).timeout
	$Label.hide()
	pass
