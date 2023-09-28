extends CharacterBody2D

var player
var speed = 50
var pebbles_chase = false
var pebbles = null


	
func _physics_process(delta):
	if pebbles_chase:
		player = get_node("../Pebbles")
		position += (pebbles.position - position)/speed
		$AnimatedSprite2D.play("Idle")
		var direction = (player.position - self.position).normalized()
		if direction.x < 0:
			get_node("AnimatedSprite2D").flip_h = true
		else:
			get_node("AnimatedSprite2D").flip_h = false
		
		move_and_collide(Vector2.ZERO)


func _on_detection_radius_body_entered(body):
	pebbles = body
	pebbles_chase = true
	
	

func _on_detection_radius_body_exited(body):
	pass
