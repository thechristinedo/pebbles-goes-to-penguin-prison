extends Area2D

@export var speed = 750
@export var life_frames = 10

func _physics_process(delta):
	position += transform.x * speed * delta
	life_frames -= 1
	if life_frames == 0:
		free()
