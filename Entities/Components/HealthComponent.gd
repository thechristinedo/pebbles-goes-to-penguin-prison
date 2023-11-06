extends Node
class_name HealthComponent

@export var movement_component_node: MovementComponent
@export var health: float = 100
@export var take_knockback: bool = true

func take_damage(damage: float, rotation: float) -> void:
	health -= damage
	if take_knockback:
		movement_component_node.knockback(rotation)
	if health < 0:
		_death()

func _death() -> void:
	print("dead!!")
