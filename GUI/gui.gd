extends CanvasLayer

func _ready():
	Input.set_custom_mouse_cursor(
		load("res://Assets/GUI/Cursor/cursor1.png"), 
		Input.CURSOR_ARROW, 
		Vector2(16,16))
