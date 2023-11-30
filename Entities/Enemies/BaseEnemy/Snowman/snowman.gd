extends CharacterBody2D

const snowball_scene = preload("res://Entities/Enemies/BaseEnemy/Snowman/snowball.tscn")
@onready var shoot_timer = $ShootTimer
@onready var rotater = $Rotater

const rotate_speed = 200
const shooter_timer_wait_time = 0.2
const spawn_point_count = 4
const radius = 25

func _ready():
	_shoot()

func _process(delta: float) -> void:
	var new_rotation = rotater.rotation_degrees + rotate_speed * delta
	rotater.rotation_degrees = fmod(new_rotation, 360)

func _shoot():
	var step = 2 * PI / spawn_point_count
	for i in range(spawn_point_count):
		var spawn_point = Node2D.new()
		var pos = Vector2(radius, 0).rotated(step * 1)
		spawn_point.position = pos
		spawn_point.rotation = pos.angle()
		rotater.add_child(spawn_point)
	
	
	# # of spirals we want to create
	for i in range(3):
		for s in rotater.get_children():
			await get_tree().create_timer(0.2).timeout
			print("shooting bullet")
			var bullet = snowball_scene.instantiate()
			get_tree().get_root().add_child(bullet)
			bullet.position = s.global_position
			bullet.rotation = s.global_rotation
	
	# waiting for 5 seconds before shooting again
	await get_tree().create_timer(5).timeout
	_shoot()
