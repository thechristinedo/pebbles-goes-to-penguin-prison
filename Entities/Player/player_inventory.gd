extends Node

@onready var gun: Gun = $"../Gun"
@onready var _inventory: Inventory = preload("res://Inventory/inventory.tres")
@onready var firerate = $"../RangedAttackComponent/Firerate"

var _current_inventory_index: int = 0

func _ready():
	player_select_slot()

func get_selected_gun() -> InventoryItem:
	return _inventory.items[_current_inventory_index]

func player_select_slot(index: int = _current_inventory_index) -> void:
	_current_inventory_index = index
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
			
