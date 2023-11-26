extends Node

class_name Fishventory

@export var resources : Dictionary = {}
var fish : FishItem = null

@onready var player = load("res://Entities/Player/pebbles.tscn").instantiate()

func add_resources(type : FishItem, amount : int):
	if (resources.has(type)):
		resources[type] = resources[type] + amount
	else:
		resources[type] = amount
	
	get_node("/root/World/GUI/Panel/FishAmount").set_count_label(player.fish_count, 1)
	
	# Update the fish if it hasn't been set yet
	if fish == null:
		fish = type

func eat_resource():
	var fish_left = get_fish_value()
	resources[fish] = fish_left - 1

func get_fish_value() -> int:
	if fish != null and resources.has(fish):
		return resources[fish]
	else:
		return 0
