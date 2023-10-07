extends "res://Enemies/enemy_base.gd"

func _get_target_name():
	return "Pebbles"


func _on_slap_radius_body_entered(body):
	var damage = 10
	if body.name == "Pebbles":
		if not can_shoot:
			$AnimatedSprite2D.play("slap")
			body.take_damage(damage)
