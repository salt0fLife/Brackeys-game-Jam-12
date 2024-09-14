extends Node

#weapons
#data = [IdentityINT, name, info1, info2, [tags], 3dScenepath]
const defaultSword = [1, "default sword", 2,0,["vanilla", "sword"], "res://imports/defaultSword/DefaultSword.glb"]
const defaultPaxel = [2, "default paxel", 1,0,["vanilla", "paxel"], "res://imports/defaultPaxel/DefaultPaxel.glb"]
const defaultBow = [3, "default bow", 2,1,["vanilla", "bow"], "res://imports/defaultBow/DefaultBow.glb"]
const leapingSword = [1, "leaping sword", 5,0,["leaping", "sword", "speedy"], "res://imports/leapingSword/LeapingSword.glb"]
const fireSword = [1, "fire sword", 5, 0, ["flaming", "sword", "heavyHanded", "speedy", "healthy"], "res://player/items/DefaultSword/default_sword.tscn"]
const critSword = [1, "crit sword", 2,0,["vanilla", "sword", "critical", "lightFooted"], "res://player/items/DefaultSword/default_sword.tscn"]
const superiorBow = [3, "superior Bow", 5,5,["vanilla", "bow"], "res://imports/superiorBow/SuperiorBow.glb"]



#materials
#data = [IdentityINT, displayName, internalReference, count, worth gb]
const twig = [0, "twig", "twig", 1, 2]
const iron = [0, "iron ore", "iron", 1, 25]

#inventory and player
#var inventory = [[0, "Iron Ore", "Iron Ore", 100, 2], [0, "Magic Salt", "Magic Salt", 100, 2], [0, "Copper Ore", "Copper Ore", 100, 2], [0, "Emerald", "Emerald", 100, 2], [0, "Ruby", "Ruby", 100, 2], [0, "Sword Handle", "swordHandle", 100, 2], [0, "Oak Wood", "Oak Wood", 100, 2], [0, "Birch Wood", "Birch Wood", 100, 2]]
var inventory = [[-1, "empty", "", 0, 0]]
#var weaponsInv = [leapingSword, superiorBow]
var weaponsInv = []
var HeldItem = 1

func set_HeldItem(value):
	HeldItem = value

var equippedSword = defaultSword
var equippedpaxel = defaultPaxel
var equippedBow = defaultBow

