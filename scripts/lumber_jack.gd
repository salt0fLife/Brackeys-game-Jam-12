extends Node3D
var shopOpen = false
var canInteract = true

#recipes
#[item to craft], [[required item, count], [different required item, count]]
var swordHandle = [[0, "Sword Handle", "swordHandle", 2], [["Oak Wood", 1], ["Birch Wood", 1]]]
var testRecipe = [[0, "special twig", "uncraftable", 1], [["twig", 1]]]
var LeapingSword = [[1, "leaping sword", 5,0,["leaping", "sword"], "res://player/items/DefaultSword/default_sword.tscn"], [["swordHandle", 1], ["Birch Wood", 2]]]

var recipeIndex = -1

@onready var recipes = [swordHandle, testRecipe, LeapingSword]

func _ready():
	$shop.hide()

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
	update_inventory_display()
	populate_shop()
	var player = get_tree().get_first_node_in_group("Player")
	player.set_disabled(true)
	shopOpen = true
	$shop.visible = true
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	pass

func close_shop():
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
	if index == -1:
		printerr("warning index not bound properly")
	else:
		#print(str(index))
		recipeIndex = index
		$shop/shopButtons/selectedRecipe/selectedRecipeDisplay.text = str(recipes[index])
		pass
	pass

func update_inventory_display():
	$shop/shopButtons/playerItems.text = ""
	for item in ItemHandler.inventory:
		$shop/shopButtons/playerItems.text += item[1] + " : " + str(item[3]) + "\n"

func _on_close_shop_button_down():
	close_shop()

func _on_craft_button_down():
	#var ingredients = recipes[]
	if recipeIndex == -1:
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
		craft(recipeIndex)
	else:
		cant_craft(recipeIndex)
	
	pass # Replace with function body.

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
	update_inventory_display()
	pass
