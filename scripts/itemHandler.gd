extends Node

#weapons
#data = [IdentityINT, name, info1, info2, [tags], 3dScenepath]
const defaultSword = [1, "default sword", 2,0,["vanilla", "sword"], "res://player/items/DefaultSword/default_sword.tscn"]
const defaultPaxel = [2, "default paxel", 1,0,["vanilla", "paxel"], "res://player/items/DefaultPaxel/default_paxel.tscn"]
const defaultBow = [3, "default bow", 2,1,["vanilla", "bow"], "res://player/items/DefaultBow/default_bow.tscn"]
const leapingSword = [1, "leaping sword", 5,0,["leaping", "sword", "speedy"], "res://player/items/DefaultSword/default_sword.tscn"]
const fireSword = [1, "fire sword", 5, 0, ["flaming", "sword", "heavyHanded", "speedy", "healthy"], "res://player/items/DefaultSword/default_sword.tscn"]
const critSword = [1, "crit sword", 2,0,["vanilla", "sword", "critical", "lightFooted"], "res://player/items/DefaultSword/default_sword.tscn"]
const superiorBow = [3, "superior Bow", 5,5,["vanilla", "bow"], "res://player/items/DefaultBow/default_bow.tscn"]

#materials
#data = [IdentityINT, displayName, internalReference, count, worth gb]
const twig = [0, "twig", "twig", 1, 2]
const iron = [0, "iron ore", "iron", 1, 25]

#inventory and player
var inventory = [[0, "twig", "twig", 1, 2]]
var weaponsInv = [leapingSword]
var HeldItem = 1

func set_HeldItem(value):
	HeldItem = value

var equippedSword = defaultSword
var equippedpaxel = defaultPaxel
var equippedBow = defaultBow

