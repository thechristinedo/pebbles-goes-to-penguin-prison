extends CharacterBody2D

const snowball_scene = preload("res://Entities/Enemies/BaseEnemy/EmperorPenguin/emperorBullet.tscn")
@onready var shoot_timer = $ShootTimer
@onready var rotater = $Rotater
@onready var icicleSound = $icicleSound

const rotate_speed = 200
const shooter_timer_wait_time = 0.5
const spawn_point_count = 8
const radius = 25

func _process(delta: float) -> void:
	var new_rotation = rotater.rotation_degrees + rotate_speed * delta
	rotater.rotation_degrees = fmod(new_rotation, 360)

func _on_shoot_timer_timeout():
	for s in rotater.get_children():
		icicleSound.play()
		var bullet = snowball_scene.instantiate()
		get_tree().get_root().add_child(bullet)
		bullet.position = s.global_position
		bullet.rotation = s.global_rotation

func _on_sight_radius_body_entered(body):
	print("ENTERED")
	if body.name == "Pebbles":
		var step = 2 * PI / spawn_point_count
		for i in range(spawn_point_count):
			var spawn_point = Node2D.new()
			var angle = step * i # use a fixed angle for each spawn point
			var pos = Vector2(radius, 0).rotated(angle)
			spawn_point.position = pos
			spawn_point.rotation = angle
			rotater.add_child(spawn_point)
		shoot_timer.wait_time = shooter_timer_wait_time
		shoot_timer.start()
