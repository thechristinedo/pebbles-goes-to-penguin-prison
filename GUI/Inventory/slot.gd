extends Panel


@onready var inventory_slot_sprite: Sprite2D = $InventorySlotTexture
@onready var item_sprite: Sprite2D = $ItemTexture

func update(item: InventoryItem):
	if !item:
		inventory_slot_sprite.frame = 0
		item_sprite.visible = false
	else:
		inventory_slot_sprite.frame = 1
		item_sprite.visible = true
		item_sprite.texture = item.texture
