extends Line2D

class_name BulletTrail

@export var bullet_scene: Bullet

var num_points: int = 10
var point_queue: Array[Vector2]
var bullet_freed: bool = false

func _physics_process(_delta):
	if bullet_scene == null:
		bullet_freed = true
		point_queue.pop_back()
	if point_queue.size() > num_points or bullet_freed:
		point_queue.pop_front()
	if bullet_scene != null:
		point_queue.append(bullet_scene.global_position)
	
	clear_points()
	
	if point_queue.is_empty():
		queue_free()
	
	for point in point_queue:
		add_point(point)
