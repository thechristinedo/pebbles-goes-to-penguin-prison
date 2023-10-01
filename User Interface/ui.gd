extends Label

class_name UI

@onready var test_label = %Label

var test_text = "Hello World":
	set(new_test_text):
		test_label.text = new_test_text

func _update_text():
	pass