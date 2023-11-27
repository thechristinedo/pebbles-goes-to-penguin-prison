extends State

@export var entity_node: CharacterBody2D
@export var movement_component: MovementComponent
@export var health_component: HealthComponent
@export var melee_component: MeleeComponent
@export var melee_distance: float = 50

var _meleeing: bool = false

func enter():
	_meleeing = true
	melee_component.target = target

func physics_update(_delta: float):
	if _meleeing:
		if melee_component.ready_to_melee: check_if_too_far()
		melee_component.attack()
		if health_component.is_dead(): _meleeing = false

func check_if_too_far() -> void:
	var distance_to_target = target.global_position.distance_to(entity_node.global_position)
	if distance_to_target > melee_distance:
		_meleeing = false
		Transitioned.emit(self, "Follow")
