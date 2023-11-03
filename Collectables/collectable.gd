extends Area2D

@onready var sprite: Sprite2D = $Sprite2D
@onready var collect_key: Sprite2D = $CollectKey

@export var inventory_item: InventoryItem

func _ready():
	update()

func update() -> void:
	if inventory_item and sprite:
		sprite.texture = inventory_item.texture
	elif sprite:
		sprite.texture = null

func collect() -> InventoryItem:
	queue_free()
	return inventory_item

func _on_area_entered(_area):
	collect_key.visible = true

func _on_area_exited(_area):
	collect_key.visible = false
