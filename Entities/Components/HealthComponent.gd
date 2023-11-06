extends Node
class_name HealthComponent

@export var entity_sprite_node: Sprite2D
@export var movement_component_node: MovementComponent
@export var health: float = 100
@export var take_knockback: bool = true
@export var flash_on_hit: bool = true

func take_damage(damage: float, rotation: float) -> void:
	health -= damage
	if take_knockback:
		movement_component_node.knockback(rotation)
	if flash_on_hit:
		flash()
	if health < 0:
		_death()

func flash() -> void:
	get_tree().create_timer(0.2).connect("timeout", _flash_callback)
	entity_sprite_node.material.set_shader_parameter("flash_modifier", 1)

func _flash_callback() -> void:
	entity_sprite_node.material.set_shader_parameter("flash_modifier", 0)

func _death() -> void:
	print("dead!!")
