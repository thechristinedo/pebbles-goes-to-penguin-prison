extends Panel

func set_heart_condition(heartCondition: int):
	var heart_sprite: Sprite2D = $HeartSprite
	if heartCondition == 0:
		heart_sprite.frame = 2
	elif heartCondition == 1:
		heart_sprite.frame = 1
	elif heartCondition == 2:
		heart_sprite.frame = 0
	else:
		push_error("wrong heart condition in heart ui!")
