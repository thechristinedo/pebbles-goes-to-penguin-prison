extends "res://Enemies/enemy_base.gd"


func _get_target_name():
	return "Pebbles"
	
func attack():
	var damage = 7
	$AnimatedSprite2D.play("slap")
	target.take_damage(damage)
