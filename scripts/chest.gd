extends Node3D
@export var ItemToGive := [3, "superior Bow", 5,5,["vanilla", "bow"], "res://player/items/DefaultBow/default_bow.tscn"]
var opened = false
@export var index := 0

func _ready():
	if Settings.chests[index] == 1:
		opened = true
		$AnimationPlayer.play("open")
	else:
		$AnimationPlayer.play("RESET")

func interact():
	open()

func take_damage(_damage, _type, _knockback):
	open()


func open():
	if !opened:
		opened = true
		Settings.chests[index] = 1
		$AnimationPlayer.play("open")
		var player = get_tree().get_first_node_in_group("Player")
		player.pickup_item(ItemToGive)
		pass
