extends Label

func set_count_label(current_fish_count : int, amount : int) -> void:
	text = str(current_fish_count + amount)
