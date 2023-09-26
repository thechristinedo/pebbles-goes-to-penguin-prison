extends CharacterBody2D

@export var move_speed: float = 250

@export var sprite_2d: Sprite2D
@export var animation_tree: AnimationTree

const LEFT = Vector2(-1, 1)
const RIGHT = Vector2(1 ,1)

const FLOAT_TOL = 0.001

func _physics_process(_delta):
	var horizontal_movement = \
		Input.get_action_strength("right") - \
		Input.get_action_strength("left")
	var vertical_movement = \
		Input.get_action_strength("down") - \
		Input.get_action_strength("up")
	
	var direction = Vector2(
		horizontal_movement, 
		vertical_movement
	).normalized()
	
	velocity = direction * move_speed
	
	move_and_slide()
	pick_new_animation_state()

func pick_new_animation_state():
	if abs(velocity.x) < FLOAT_TOL && abs(velocity.y) < FLOAT_TOL:
		animation_tree["parameters/conditions/not_moving"] = true
		animation_tree["parameters/conditions/moving"] = false
	else:
		animation_tree["parameters/conditions/not_moving"] = false
		animation_tree["parameters/conditions/moving"] = true

