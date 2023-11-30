class_name FishItem extends Resource

var name : String = "Fish"
var healing_value : int = 25
var description : String = "Restores 25 health points."
var texture : Texture2D

@export var display_name : String = "Fish"


func serialize() -> Dictionary:
	return {
		"name": name,
		"healing_value": healing_value,
		"description": description,
		"display_name": display_name,
		"texture_path": texture.resource_path
	}

static func deserialize(data: Dictionary) -> FishItem:

	var fish_item = FishItem.new()
	fish_item.name = data.get("name", "")
	fish_item.healing_value = data.get("healing_value", 0)
	fish_item.description = data.get("description", "")
	fish_item.display_name = data.get("display_name", "")
	if data.get("texture_path","")!= "":
		fish_item.texture = load(data["texture_path"])
	else:
		fish_item.texture = null
	return fish_item
