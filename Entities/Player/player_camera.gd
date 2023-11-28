extends Camera2D

@onready var shake_timer: Timer = $ShakeTimer

@export var lerp_strength: float = 15
var _will_lerp: bool = true
var _current_shake_strength: float = 0

func _process(delta):
#	if World.INPUT_SCHEME == World.INPUT_SCHEMES.GAMEPAD:
#		if target.crosshair:
#			target_position = target.crosshair.global_position
#		else:
#			target_position = target.position
	
	if _will_lerp:
		_current_shake_strength = lerpf(_current_shake_strength, 0, delta * lerp_strength)
		if _current_shake_strength < 0.1: _current_shake_strength = 0
	
	offset = Vector2(
		randf_range(-1.0, 1.0) * _current_shake_strength,
		randf_range(-1.0, 1.0) * _current_shake_strength
	)

func shake(shake_strength: float = 15, time: float = 0.1) -> void:
	shake_timer.wait_time = time
	_current_shake_strength = shake_strength
	shake_timer.start()
	_will_lerp = false

func _on_shake_cooldown_timeout():
	_will_lerp = true
