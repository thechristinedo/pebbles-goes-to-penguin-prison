extends Label

func _ready():
	text = "0"

func set_count_label(current_fish_count : int, amount : int) -> void:
	print("Fish amount: " + str(current_fish_count + amount))
	text = str(current_fish_count + amount)
