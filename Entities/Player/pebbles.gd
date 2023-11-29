extends CharacterBody2D

class_name Player

@onready var animation_tree: AnimationTree = $AnimationTree
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var camera: Camera2D = $Camera2D
@onready var shadow: Sprite2D = $Shadow
@onready var gun: Gun = $Gun
@onready var crosshair = $Crosshair
@export var crosshair_range := 50.0
@onready var character_sprite: Sprite2D = $PebblesSprite
@onready var ranged_attack_component: Node = $RangedAttackComponent
@onready var inventory_node: Node = $Inventory
@onready var movement_particles: GPUParticles2D = $MovementParticles
@onready var gameOver = load("res://GUI/User Interface/UI_menu_scenes/game_over_screen.tscn").instantiate()

# Audio
@onready var reload = $reload
@onready var pickup = $pickup
@onready var shotgunShot = $shotgunShot
@onready var revolverShot = $revolverShot
@onready var machinegunShot = $machinegunShot
@onready var walkSound = $walkSound
@onready var slideSound = $slideSound

# Health
@onready var fishventory = $Fishventory
@export var max_health: int = 10
@onready var health: int = max_health
var is_eating = false
@onready var fish_count: int

@export var speed: float = 200
var current_animation: String = "idle"
var is_sliding = false 

var slide_cooldown : float = 0.5
var current_slide_cooldown : float = 0.0

var enemy_inattack_range = false
var enemy_attack_cooldown = true

# Controller support
const ROTATE_SPEED = 20

signal health_updated
signal fish_update
signal pebbles_death
signal pebbles_shoot

var last_health: int = 0

var collectables: Array[Area2D]
var invincible: bool = false

func _ready():
	animation_tree.active = true
	EventBus.input_scheme_changed.connect(_on_input_scheme_changed)
	print("Health: ", health, " Fish: ",fish_count)

func _physics_process(_delta):
	update_animation()
	handle_player_movement()
	handle_player_shoot()
	handle_player_interactions()
	move_and_slide()
	# Handle weapon rotation
	update_weapon_rotation(_delta)
	if last_health != health:
		last_health = health
		get_node("/root/World").update_player_health(health, max_health)
	
		# Add a 2-second cooldown to the "slide" action
	if Input.is_action_pressed("slide") and not is_sliding and current_slide_cooldown <= 0:
		is_sliding = true
		slide()
		slideSound.pitch_scale = randf_range(0.8, 1.2)
		slideSound.play()

		# Set the cooldown timer
		current_slide_cooldown = slide_cooldown
		
	if is_sliding or is_eating:
		invincible = true
		$Gun.visible = false
	else:
		invincible = false
		$Gun.visible = true
	
		
	# press shift to heal (eat)
	
	if current_slide_cooldown > 0:
		current_slide_cooldown -= _delta
		
	
	fish_count = fishventory.get_fish_value()
	get_node("/root/World/GUI/Panel/FishAmount").set_count_label(fish_count, 0)

func handle_player_shoot() -> void:
	gun.aim(get_global_mouse_position())
	
	if Input.is_action_pressed("shoot"):
		var current_gun = inventory_node.get_selected_gun()
		if current_gun:
			ranged_attack_component.set_fire_rate(current_gun.shooter.firerate)
			var has_shot = ranged_attack_component.shoot()
			if has_shot: 
				var gunType = ranged_attack_component.gun.get_type()
				if gunType == "shotgun":
					shotgunShot.play()
				elif gunType == "revolver":
					revolverShot.play()
				elif gunType == "machinegun":
					machinegunShot.play()
				camera.shake(current_gun.shooter.recoil, 0.05)

func handle_player_movement() -> void:
	if Input.is_action_just_pressed("left") or Input.is_action_just_pressed("right") or Input.is_action_just_pressed("up") or Input.is_action_just_pressed("down"):
		if $walkTimer.time_left <= 0:
				walkSound.pitch_scale = randf_range(0.8, 1.2)
				walkSound.play()
				$walkTimer.start(0.2)
	var movement_direction = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	velocity = movement_direction * speed
	movement_particles.emitting = true if velocity else false
	var angle_to_mouse = get_angle_to(get_global_mouse_position())
	if angle_to_mouse < PI/2 and angle_to_mouse > -PI/2:
		character_sprite.flip_h = false # right
	else:
		character_sprite.flip_h = true # left

func update_weapon_rotation(_delta, force_update_position = false) -> void:
	if World.INPUT_SCHEME == World.INPUT_SCHEMES.KEYBOARD_AND_MOUSE:
		var mouse_pos = get_local_mouse_position()
		var new_transform = gun.transform.looking_at(mouse_pos)
		gun.transform = gun.transform.interpolate_with(new_transform, ROTATE_SPEED * _delta)
	elif World.INPUT_SCHEME == World.INPUT_SCHEMES.GAMEPAD:
		var aim_direction := Input.get_vector("weapon aim left", "weapon aim right", "weapon aim up", "weapon aim down")
		if force_update_position || aim_direction != Vector2.ZERO:
			var angle = aim_direction.angle()
			gun.global_rotation = angle
			crosshair.global_position = global_position + (Vector2(cos(angle), sin(angle)) * crosshair_range)
		crosshair.global_rotation = 0

func handle_player_interactions() -> void:
	# pickup gun
	if collectables.size() and Input.is_action_just_pressed("interact"):
		if !inventory_node.is_full():
			reload.play()
			pickup.play()
			inventory_node.insert_gun(collectables.pop_back().collect())
	
	# drop gun
	if Input.is_action_just_pressed("drop gun"):
		var dropped_gun_item = inventory_node.drop_gun()
		if dropped_gun_item:
			$dropSound.play()
			var dropped_gun_collectable = load(dropped_gun_item.path_to_collectable_scene).instantiate()
			dropped_gun_collectable.inventory_item = dropped_gun_item
			dropped_gun_collectable.position = position
			dropped_gun_collectable.update()
			
			var room = get_node("/root/World/RoomManager/Room")
			room.add_child(dropped_gun_collectable)
	
	# scroll through inventory
	if Input.is_action_just_pressed("scroll up"):
		inventory_node.scroll_up()
	if Input.is_action_just_pressed("scroll down"):
		inventory_node.scroll_down()
	
	# press shift to heal (eat)
	if Input.is_action_just_pressed("eat"):
		if fishventory.get_fish_value() > 0:
			is_eating = true
			heal(25)
			fishventory.eat_resource()
			#print("Fish left in inventory: ", fishventory.get_fish_value())
			get_node("/root/World/GUI/Panel/FishAmount").set_count_label(fish_count, -1)
		else:
			print("No fish in fishventory! Collect some fish!")


func update_animation() -> void:
	# Make sure we only update the animation if we are not sliding or eating
	if is_sliding or is_eating:
		return

	var anim_state = animation_tree.get("parameters/playback") as AnimationNodeStateMachinePlayback
	# Determine the appropriate animation based on velocity
	if velocity == Vector2.ZERO:
		current_animation = "idle"
	else:
		current_animation = "run"
	
	if anim_state.get_current_node() != current_animation:
		anim_state.travel(current_animation)
	
	animation_tree["parameters/conditions/is_running"] = velocity != Vector2.ZERO
	animation_tree["parameters/conditions/is_not_running"] = velocity == Vector2.ZERO

func _on_pickup_area_area_entered(area):
	if area.has_method("collect"): 
		collectables.append(area)

func _on_pickup_area_area_exited(area):
	if collectables.size() and area == collectables[collectables.size()-1]:
		collectables.pop_back()

func slide():
	speed *= 1.5
	animation_tree.set("parameters/conditions/is_sliding", true)
	var anim_state = animation_tree.get("parameters/playback") as AnimationNodeStateMachinePlayback
	anim_state.travel("slide")
	await get_tree().create_timer(0.25).timeout
	reset_slide()
	
func reset_slide():
	speed /= 1.5
	is_sliding = false
	animation_tree.set("parameters/conditions/is_sliding", false)
	var anim_state = animation_tree.get("parameters/playback") as AnimationNodeStateMachinePlayback
	anim_state.travel(current_animation)

func heal(amount: int):
	animation_tree.set("parameters/conditions/is_eating", true)
	var anim_state = animation_tree.get("parameters/playback") as AnimationNodeStateMachinePlayback
	anim_state.travel("eat")
	health += amount

	if health > max_health:
		health = max_health
	#print("Health is: ", health)
	await get_tree().create_timer(0.7).timeout
	reset_heal()
	
func reset_heal():
	is_eating = false
	
func take_damage(damage: int = 1) -> void:
	#damage is only going to be 1 for pebbles 
	if invincible: return
	health -= damage
	if health <= 0:
		health = 0
		#sprite2.material.set_shader_parameter("flash_modifier", 0)
		animation_player.play("death")
		await animation_player.animation_finished
		get_tree().paused = true
		add_child(gameOver)
		gun.visible = false
		character_sprite.visible = false
		shadow.visible = false
		gameOver.visible = true
		print("dead")
		pebbles_death.emit()
	get_node("/root/World").update_player_health(health, max_health)
	invincible_frames()

func invincible_frames() -> void:
	invincible = true
	character_sprite.material.set_shader_parameter("flash_modifier", 0.8)
	get_tree().create_timer(0.5).connect("timeout", invincible_reset)

func invincible_reset() -> void:
	invincible = false
	character_sprite.material.set_shader_parameter("flash_modifier", 0)
	
func _on_input_scheme_changed(scheme) -> void:
	if scheme == World.INPUT_SCHEMES.GAMEPAD:
		crosshair.show()
		update_weapon_rotation(0, true)
	else:
		crosshair.hide()
		
func get_health() -> int:
	return health

func get_fish_count() -> int:
	return fish_count

func get_inventory_data():
	return inventory_node.get_inventory_data()
	
func set_new_data():
	health = health
	fish_count = fish_count
