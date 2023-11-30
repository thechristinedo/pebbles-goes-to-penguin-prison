class_name Fishventory extends Node

var resources : Dictionary = {}
@onready var player = RoomManager.pebbles
var fish : FishItem = null
var fish_resource

func add_resources(type : FishItem, amount : int):
	if not resources.has(type.name):
		resources["Fish"] = {"item": type, "count": 0}
	resources["Fish"]["count"] += amount
		

func eat_resource():
	if resources.has("Fish"):
		var fish_left = resources["Fish"]["count"] - 1
		resources["Fish"]["count"] = max(fish_left, 0)

func get_fish_value() -> int:
	if resources.has("Fish"):
		return resources["Fish"]["count"]
	else:
		return 0
		
func serialize() -> Dictionary:
	var serialized_data: Dictionary = {}
	for fish_name in resources.keys():
		var fish_data = resources[fish_name]
		serialized_data[fish_name] = {
			"count": fish_data["count"],
			"item_data": fish_data["item"].serialize()
		}
	return serialized_data

func deserialize(data: Dictionary):
	resources.clear()
	for key in data.keys():
		var fish_data = data[key]
		var fish_item = FishItem.deserialize(fish_data.get("item_data", {}))
		resources[key] = {
			"item": fish_item,
			"count": fish_data.get("count", 0)
		}

