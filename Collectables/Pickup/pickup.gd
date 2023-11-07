extends Area2D

class_name Pickup

@onready var collision_shape : CollisionShape2D = $CollisionShape2D

@onready var sprite: Sprite2D = $ItemSprite
@onready var collect_key: Sprite2D = $CollectKey
@export var inventory_item: InventoryItem

func _ready():
	update()

func update() -> void:
	if inventory_item and sprite:
		sprite.texture = inventory_item.texture
	elif sprite:
		sprite.texture = null

var launch_velocity : Vector2 = Vector2.ZERO
var move_duration : float = 0
var time_since_launch : float = 0
var launching : bool = false :
	set(is_launching): 
		launching = is_launching
		collision_shape.disabled = launching

func collect() -> InventoryItem:
	queue_free()
	return inventory_item

func _on_area_entered(area):
	if area.name == "PlayerInteractArea":
		collect_key.visible = true

func _on_area_exited(area):
	if area.name == "PlayerInteractArea":
		collect_key.visible = false

func _process(delta):
	if (launching):
		position += launch_velocity * delta
		time_since_launch += delta
		
		if (time_since_launch >= move_duration):
			launching = false

func launch(velocity : Vector2, duration : float):
	launch_velocity = velocity
	move_duration = duration
	time_since_launch = 0
	launching = true
