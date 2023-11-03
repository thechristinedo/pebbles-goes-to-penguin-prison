extends Node

@onready var gun: Gun = $"../Gun"
@onready var _inventory: Inventory = preload("res://Inventory/inventory.tres")
@onready var firerate = $"../RangedAttackComponent/Firerate"

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
	if _inventory.items[_inventory.selected_slot] == null:
		_inventory.items[_inventory.selected_slot] = resource
		player_select_slot()
		return true
	
	for i in range(_inventory.items.size()):
		if !_inventory.items[i]: 
			_inventory.items[i] = resource
			player_select_slot()
			return true
	return false

func drop_gun(index: int = _inventory.selected_slot) -> InventoryItem:
	var item = _inventory.items[index]
	_inventory.items[index] = null
	player_select_slot()
	return item

func get_selected_gun() -> InventoryItem:
	return _inventory.items[_inventory.selected_slot]

func player_select_slot(index: int = _inventory.selected_slot) -> void:
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
			
