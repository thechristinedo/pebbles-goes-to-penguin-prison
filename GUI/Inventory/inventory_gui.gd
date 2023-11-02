extends Control


@onready var inventory: Inventory = preload("res://Inventory/inventory.tres")
@onready var slots: Array = $GridContainer.get_children()

func _ready():
	update()

func update():
	for i in range(min(inventory.items.size(), slots.size())):
		slots[i].update(inventory.items[i])
