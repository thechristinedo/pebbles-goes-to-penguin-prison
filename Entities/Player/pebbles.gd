extends CharacterBody2D

@onready var animation_tree: AnimationTree = $AnimationTree
@onready var camera: Camera2D = $Camera2D
@onready var gun: Gun = $Gun
@onready var character_sprite: Sprite2D = $PebblesSprite
@onready var ranged_attack_component = $RangedAttackComponent
@onready var inventory_node = $Inventory

@export var speed: float = 200


func _physics_process(_delta):
	update_animation()
	handle_player_movement()
	handle_player_shoot()
	move_and_slide()

func handle_player_shoot() -> void:
	gun.aim(get_global_mouse_position())
	
	if Input.is_action_pressed("shoot"):
		var current_gun = inventory_node.get_selected_gun()
		ranged_attack_component.set_fire_rate(current_gun.shooter.firerate)
		var has_shot = ranged_attack_component.shoot()
		if has_shot: 
			camera.shake(current_gun.shooter.recoil, 0.05)
		

func handle_player_movement() -> void:
	var movement_direction = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	velocity = movement_direction * speed
	
	var angle_to_mouse = get_angle_to(get_global_mouse_position())
	if angle_to_mouse < PI/2 and angle_to_mouse > -PI/2:
		character_sprite.flip_h = false # right
	else:
		character_sprite.flip_h = true # left

func update_animation() -> void:
	match velocity:
		Vector2.ZERO:
			animation_tree["parameters/conditions/is_running"] = false
			animation_tree["parameters/conditions/is_not_running"] = true
		_:
			animation_tree["parameters/conditions/is_running"] = true
			animation_tree["parameters/conditions/is_not_running"] = false

func _on_area_entered() -> void:
	print("hello")
