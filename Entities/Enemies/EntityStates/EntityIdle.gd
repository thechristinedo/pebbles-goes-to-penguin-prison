extends State

@export var movement_component: MovementComponent
@export var health_component: HealthComponent

func pause_wander():
	movement_component.stop_movement()
	get_tree().create_timer(randf_range(1,2)).connect("timeout", random_wander)

func random_wander():
	if health_component.is_dead(): 
		movement_component.stop_movement()
		return
	var move_direction = Vector2(randf_range(-1,1), randf_range(-1,1)).normalized()
	movement_component.set_movement_direction(move_direction)
	get_tree().create_timer(randf_range(1,2)).connect("timeout", pause_wander)

func enter():
	movement_component.walking = true
	random_wander()
