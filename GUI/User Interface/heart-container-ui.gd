extends HBoxContainer

@onready var heart_ui = preload("res://GUI/User Interface/heart-ui.tscn")

var hearts_ready: bool = false

func init_health(max_health: int):
	for i in range(ceili(max_health / 2.0)):
		var heart = heart_ui.instantiate()
		heart.set_heart_condition(0)
		add_child(heart)

func set_health(health: int, max_health: int):
	if !hearts_ready:
		init_health(max_health)
		hearts_ready = true
	var all_hearts: int = ceili(max_health / 2.0)
	var full_hearts: int = floori(health / 2.0)
	var carry: bool = health % 2 == 1
	for i in range(all_hearts):
		var heart = get_child(i)
		if i < full_hearts:
			heart.set_heart_condition(2)
		else:
			heart.set_heart_condition(0)
	if carry:
		var heart = get_child(full_hearts)
		heart.set_heart_condition(1)
