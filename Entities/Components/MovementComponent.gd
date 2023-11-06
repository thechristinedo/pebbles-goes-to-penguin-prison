extends Node
class_name MovementComponent

@export var entity_node: CharacterBody2D
@export var entity_sprite_node: Sprite2D
@export var animation_tree: AnimationTree
@export var speed: float = 30
@export var knockback_effect: float = 100
@export var knockback_recovery: float = 0.4

var walking: bool = false
var _last_knockback_rotation = 0
var _current_knockback_strength: float = 0

func _physics_process(_delta):
	entity_node.move_and_slide()
	
	var knockback = Vector2.RIGHT.rotated(_last_knockback_rotation) * _current_knockback_strength
	entity_node.velocity += knockback
	_current_knockback_strength *= knockback_recovery

func set_movement_direction(direction: Vector2) -> void:
	entity_node.velocity = direction.normalized() * speed
	if walking: entity_node.velocity /= 2
	
	if direction.x < 0: entity_sprite_node.flip_h = true
	else: 				entity_sprite_node.flip_h = false
	
	animation_tree["parameters/conditions/is_running"] = true
	animation_tree["parameters/conditions/not_running"] = false

func stop_movement() -> void:
	entity_node.velocity = Vector2(0,0)
	animation_tree["parameters/conditions/is_running"] = false
	animation_tree["parameters/conditions/not_running"] = true

func knockback(rotation: float) -> void:
	_last_knockback_rotation = rotation
	_current_knockback_strength = knockback_effect
