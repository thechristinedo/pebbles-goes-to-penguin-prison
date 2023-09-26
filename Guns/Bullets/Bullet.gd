extends Area2D

@export var speed = 1000
@export var life_frames = 50

func _physics_process(delta):
	position += transform.x * speed * delta
	life_frames -= 1
	if life_frames == 0:
		free()

func _on_body_entered(body):
	print("collision")
	queue_free()
	
