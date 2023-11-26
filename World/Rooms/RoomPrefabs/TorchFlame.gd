extends PointLight2D

@export var scale_low: float = 0.8
@export var scale_high: float = 1.2
@export var rate: float = 0.5
var target: float = (scale_high + scale_low) / 2
var TOLERANCE: float = 0.01

func _physics_process(_delta):
	if absf(texture_scale - target) < TOLERANCE: _new_target()
	texture_scale = lerpf(texture_scale, target, rate)

func _new_target() -> void:
	target = randf_range(scale_low, scale_high)
