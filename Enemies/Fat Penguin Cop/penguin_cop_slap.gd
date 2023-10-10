extends "res://Enemies/enemy_base.gd"
@onready var penguinSlap = $penguinSlap

func _get_target_name():
	return "Pebbles"
	
func attack():
	penguinSlap.play()
	var damage = 5
	$AnimatedSprite2D.play("slap")
	target.take_damage(damage)



