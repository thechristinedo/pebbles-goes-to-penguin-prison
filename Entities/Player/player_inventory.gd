extends Node

@onready var gun: Gun = $"../Gun"
@onready var _inventory: Inventory = preload("res://Inventory/inventory.tres")
@onready var firerate = $"../RangedAttackComponent/Firerate"
@onready var player = RoomManager.pebbles

func _ready():
	player_select_slot()
	
	

func is_full() -> bool:
	if null in _inventory.items:
		return false
	return true

func scroll_up() -> void:
	_inventory.selected_slot = wrapi(_inventory.selected_slot - 1, 0, 5)
	player_select_slot()

func scroll_down() -> void:
	_inventory.selected_slot = wrapi(_inventory.selected_slot + 1, 0, 5)
	player_select_slot()

func insert_gun(resource: InventoryItem) -> bool:
	for i in range(_inventory.items.size()):
		if (!_inventory.items[i]):
			_inventory.items[i] = resource
			print("Inserting Gun: ", resource)
			if (i == _inventory.selected_slot and gun):
				player_select_slot()
			return true  # Item successfully added
	return false

func drop_gun(index: int = _inventory.selected_slot) -> InventoryItem:
	var item = _inventory.items[index]
	_inventory.items[index] = null
	player_select_slot()
	return item

func get_selected_gun() -> InventoryItem:
	return _inventory.items[_inventory.selected_slot]

func player_select_slot(index: int = _inventory.selected_slot) -> void:
		print("gun...", gun)
		_inventory.selected_slot = index
		gun.inventory_item = _inventory.items[index]
		gun.update_texture()

func _input(event):
	var just_pressed = event.is_pressed() and not event.is_echo()
	if just_pressed and event is InputEventKey:
		match event.keycode:
			KEY_1: player_select_slot(0)
			KEY_2: player_select_slot(1)
			KEY_3: player_select_slot(2)
			KEY_4: player_select_slot(3)
			KEY_5: player_select_slot(4)
			_: pass

func get_inventory_data() -> Array:
	var inventory_data = []
	for item in _inventory.items:
		if item:
			var shooter_data ={}
			if item.shooter:
				shooter_data["path"] = item.shooter.resource_path

			inventory_data.append({
				"name": item.name,
				"texture_path": item.texture.resource_path,
				"stackable": item.stackable,
				"shooter": shooter_data,
				"muzzle": item.muzzle,
				"path_to_collectable_scene": item.path_to_collectable_scene
				})
		else:
			inventory_data.append(null)
	return inventory_data

func set_inventory_data(data: Array):
	if (!_inventory):
		print("inventory null")
		_inventory = load("res://Inventory/inventory.tres")
	clear_inventory()
	print("The data: ", data)
	for item_data in data:
		if item_data:
			print("ITEM DATA...", item_data)
			var new_item = InventoryItem.new()
			new_item.name = item_data["name"]
			new_item.texture = load(item_data["texture_path"]) if item_data["texture_path"] != "" else null
			new_item.stackable = item_data["stackable"]
			new_item.muzzle = item_data["muzzle"]
			new_item.path_to_collectable_scene = item_data["path_to_collectable_scene"]
			new_item.shooter = load(item_data["shooter"]["path"])
			insert_gun(new_item)
		else:
			insert_gun(null)

func clear_inventory():
	for i in range(_inventory.items.size()):
		#set null to items
		_inventory.items[i] = null
		# reset selected slots
		_inventory.selected_slot = 0
