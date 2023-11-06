extends Panel


@onready var inventory_slot_sprite: Sprite2D = $InventorySlotTexture
@onready var item_sprite: Sprite2D = $ItemTexture

func update(item: InventoryItem, selected: bool):
	inventory_slot_sprite.frame = 1 if selected else 0
	item_sprite.visible = true if item else false
	item_sprite.texture = item.texture if item else null
