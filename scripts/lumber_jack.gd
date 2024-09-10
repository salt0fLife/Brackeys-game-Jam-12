extends Node3D
var shopOpen = false
var canInteract = true

#recipes
#[item to craft], [[required item, count], [different required item, count]]
var swordHandle = [[0, "Sword Handle", "swordHandle", 10], [["twig", 5], ["Wood", 1]]]
var testRecipe = [[0, "nonItem", "", 0], ["twig", 1]]

@onready var recipes = [swordHandle, testRecipe]

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
		print(str(index))
		pass
	pass

func update_inventory_display():
	$shop/shopButtons/playerItems.text = ""
	for item in ItemHandler.inventory:
		$shop/shopButtons/playerItems.text += item[1] + " : " + str(item[3]) + "\n"

func _on_close_shop_button_down():
	close_shop()
