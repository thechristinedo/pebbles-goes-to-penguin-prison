extends Sprite2D

class_name Gun

@onready var inventory_item: InventoryItem

func _ready():
	position.y = position.y + 7
	offset.x = 7
	update_texture()

func update_texture() -> void:
	if inventory_item: 
		texture = inventory_item.texture
	else:
		texture = null

func aim(target: Vector2) -> float:
	look_at(target)
	rotation = wrapf(rotation, -PI, PI)
	if rotation < PI/2 and rotation > -PI/2:
		flip_v = false # right
	else:
		flip_v = true # left
	return rotation

func shoot() -> bool:
	if inventory_item and inventory_item.shooter: 
		var bullets = inventory_item.shooter.shoot() as Array[Bullet]
		if bullets.size():
			for bullet in bullets:
				bullet.rotation += rotation
				bullet.position += Vector2(0, inventory_item.muzzle.y)
				bullet.position += (Vector2.RIGHT * inventory_item.muzzle.x).rotated(rotation)
				owner.add_child(bullet)
			return true
	return false
