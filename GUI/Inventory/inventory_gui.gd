extends Control


@onready var inventory: Inventory = preload("res://Inventory/inventory.tres")
@onready var slots: Array = $GridContainer.get_children()

func _process(_delta):
	update_textures()

func update_textures():
	for i in range(min(inventory.items.size(), slots.size())):
		var selected = i == inventory.selected_slot
		slots[i].update(inventory.items[i], selected)
