extends CharacterBody2D

@export var max_health: int = 10
@export var ammo: int = 50
@export var move_speed: float = 250
@export var sprite_2d: Sprite2D
@export var animation_tree: AnimationTree
@export var bullet_scene: PackedScene

@onready var health: int = max_health
@onready var gunShot = $gunShot

const LEFT = Vector2(-1, 1)
const RIGHT = Vector2(1 ,1)
const FLOAT_TOL = 0.001


signal health_update
signal pebbles_death
signal pebbles_shoot

func _ready():
	animation_tree.active = true

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
	
	if velocity.length() == 0:
		$walking.stop()
	else:
		if $Timer.is_stopped():
			$walking.pitch_scale = randf_range(0.8, 1.2)
			$walking.play()
			$Timer.start(0.2)
	
	
	move_and_slide()
	pick_new_animation_state()
	
	if Input.is_action_just_pressed("shoot"):
		shoot()
  
	if Input.is_action_just_pressed("slap"):
		slap()
	
	#print("Current Animation: ", $AnimationPlayer.current_animation)
	#print("Sprite Frame: ", $Sprite2D.frame)

	
	if Input.is_action_just_pressed("ui_text_backspace"):
		take_damage(1)


func pick_new_animation_state():
	if abs(velocity.x) < FLOAT_TOL && abs(velocity.y) < FLOAT_TOL:
		animation_tree["parameters/conditions/not_moving"] = true
		animation_tree["parameters/conditions/moving"] = false
	else:
		animation_tree["parameters/conditions/not_moving"] = false
		animation_tree["parameters/conditions/moving"] = true

func shoot():
	if !$ShootCooldown.is_stopped():
		print($ShootCooldown.time_left)
		return
	$ShootCooldown.start()
	if ammo <= 0: return
	ammo -= 1
	pebbles_shoot.emit(ammo)
	
	gunShot.play()
	var bullet1: Area2D = bullet_scene.instantiate()
	var bullet2: Area2D = bullet_scene.instantiate()
	var bullet3: Area2D = bullet_scene.instantiate()

	bullet1.global_position = get_node("Gun/Muzzle").global_position
	bullet2.global_position = get_node("Gun/Muzzle").global_position
	bullet3.global_position = get_node("Gun/Muzzle").global_position
	
	bullet1.rotation = get_node("Gun").rotation + 0.1
	bullet2.rotation = get_node("Gun").rotation
	bullet3.rotation = get_node("Gun").rotation - 0.1
	
	owner.add_child(bullet1)
	owner.add_child(bullet2)
	owner.add_child(bullet3)
	
func slap():
	$AnimationPlayer.play("slap")

func _on_slap_area_entered(area):
	if area.is_in_group("hurtbox"):
		area.take_damage()

func take_damage(damage: int) -> void:
	health -= damage
	if health <= 0:
		health = 0
		print("dead")
		pebbles_death.emit()
	health_update.emit(health, max_health)

