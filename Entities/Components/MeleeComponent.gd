extends Node2D
class_name MeleeComponent

@export var entity_sprite: Sprite2D
@export var damage: int = 2
@export var ready_time: float = 1
@export var cooldown_time: float = 1
@export var melee_range: float = 50

@onready var melee_sprite: Sprite2D = $MeleeSprite
@onready var animation_player: AnimationPlayer = $AnimationPlayer

var target: CharacterBody2D
var ready_to_melee: bool = true

func attack() -> void:
	if !ready_to_melee: return
	ready_to_melee = false
	get_tree().create_timer(ready_time).connect("timeout", _melee)

func _melee() -> void:
	var distance_to_target = target.global_position.distance_to(owner.global_position)
	melee_sprite.look_at(target.global_position)
	if owner.has_node("AnimationPlayer"):
		var animation_player = owner.get_node("AnimationPlayer") as AnimationPlayer
		if animation_player.has_animation("slap"):
			animation_player.play("slap")
	if target.has_method("take_damage") and distance_to_target < melee_range:
		target.take_damage(damage)
	get_tree().create_timer(ready_time).connect("timeout", _cooldown)

func _cooldown() -> void:
	ready_to_melee = true
