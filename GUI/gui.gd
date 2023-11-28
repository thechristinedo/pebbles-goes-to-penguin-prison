extends CanvasLayer

# Cursor
const CURSOR = preload("res://Assets/GUI/Cursor/cursor1.png")
const ANIMATION_FRAMES = [
	preload("res://Assets/GUI/Cursor/cursor2.png"),
	preload("res://Assets/GUI/Cursor/cursor3.png"),
	preload("res://Assets/GUI/Cursor/cursor4.png"),
	preload("res://Assets/GUI/Cursor/cursor5.png")
]
@export var frames_per_second = 16.0
var current_frame = 0

@onready var game_input_scheme = preload("res://World/world.gd").INPUT_SCHEME

func _ready():
#	begin_load()
	$AnimationPlayer.play("tutorial_dialog")
	$CursorAnimationTimer.connect("timeout", Callable(self, "update_frame"))
	
	EventBus.input_scheme_changed.connect(_on_input_scheme_changed)
	
	Input.set_custom_mouse_cursor(
		CURSOR, 
		Input.CURSOR_ARROW, 
		Vector2(16,16))

func _on_input_scheme_changed(_scheme) -> void:
	update_cursor()

func update_cursor():
	if game_input_scheme == World.INPUT_SCHEMES.GAMEPAD:
		Input.set_custom_mouse_cursor(null, Input.CURSOR_ARROW)
	else:
		begin_load()

func begin_load():
	$CursorAnimationTimer.start(1.0/frames_per_second)
	current_frame = 0
	Input.set_custom_mouse_cursor(ANIMATION_FRAMES[current_frame], Input.CURSOR_ARROW, Vector2(16,16))

func update_frame():
	if Input.get_current_cursor_shape() != Input.CURSOR_ARROW:
		return
	
	current_frame += 1
	if current_frame >= ANIMATION_FRAMES.size():
		current_frame = 0
	Input.set_custom_mouse_cursor(ANIMATION_FRAMES[current_frame], Input.CURSOR_ARROW, Vector2(16,16))
