extends GPUParticles2D

func _ready():
	await get_tree().create_timer(0.59).timeout
	queue_free()
