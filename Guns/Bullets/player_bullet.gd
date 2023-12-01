class_name Bullet
extends RigidBody2D

@export var speed: float = 800
@export var lifetime: float = 0.1
@export var damage: float = 20.01

const impact_smoke: PackedScene = preload("res://Guns/Bullets/Effects/impact_smoke.tscn")

func _ready():
	add_to_group("bullets")
	var player = get_tree().get_nodes_in_group("player")[0]
	if player.animation_tree.get("parameters/conditions/is_sliding"):
		# If yes, ignore the player layer
		set_collision_mask_value(1, false)
		get_node("Area2D").set_collision_mask_value(1, false)

func _physics_process(delta):
	linear_velocity = Vector2.RIGHT.rotated(rotation) * speed
	update_texture()

func update_texture():
	if speed < 800:
		$Sprite2D.texture = load("res://Assets/Guns/Bullets/enemyBullet.png")
	else:
		$Sprite2D.texture = load("res://Assets/Guns/Bullets/bullet.png")
		

func _on_area_2d_body_entered(body):
	if body.name == "Bullet": pass
	if body.get_node_or_null("HealthComponent"):
		var body_health_component = body.get_node("HealthComponent") as HealthComponent
		body_health_component.take_damage(damage, rotation)
	if body.has_method("take_damage"):
		body.take_damage()
	destroy()

func destroy():
	var smoke = impact_smoke.instantiate()
	smoke.global_position = global_position
	get_node("/root/World/RoomManager/Room").add_child(smoke)
	queue_free()
