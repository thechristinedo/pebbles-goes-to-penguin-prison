extends CharacterBody2D


var speed = 50
var pebbles_chase = false
var pebbles = null


	
func _physics_process(delta):
	if pebbles_chase:
		position +=(pebbles.position - position)/speed
		$AnimatedSprite2D.play("Idle")
		move_and_collide(Vector2.ZERO)


func _on_detection_radius_body_entered(body):
	pebbles = body
	pebbles_chase = true
	

func _on_detection_radius_body_exited(body):
	pass
