extends Area2D

@onready var sprite: Sprite2D = $Sprite2D

@export var inventory_item: InventoryItem

func _ready():
	sprite.texture = inventory_item.texture

func collect() -> InventoryItem:
	queue_free()
	return inventory_item
