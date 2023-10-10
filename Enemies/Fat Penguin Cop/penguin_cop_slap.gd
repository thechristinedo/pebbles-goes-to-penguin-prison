extends "res://Enemies/enemy_base.gd"


func _get_target_name():
	return "Pebbles"
	
func attack():
	$AnimatedSprite2D.play("slap")

func _on_animated_sprite_2d_frame_changed():
	var damage = 5
	if $AnimatedSprite2D.frame == 2 && $AnimatedSprite2D.animation == "slap":
		target.take_damage(damage)


