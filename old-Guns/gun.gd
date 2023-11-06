extends Sprite2D


@export var sprite_2d: Sprite2D
@export var player: CharacterBody2D

const GUN_LEFT: Vector2 = Vector2(0.75, -0.75)
const GUN_RIGHT: Vector2 = Vector2(0.75, 0.75)

const PLAYER_LEFT: Vector2 = Vector2(-1, 1)
const PLAYER_RIGHT: Vector2 = Vector2(1, 1)

func _physics_process(_delta):
	rotation = __wrap(rotation)
	look_at(get_global_mouse_position())
	__scale_gun_and_player()

func __wrap(angle: float) -> float:
	if angle < 0:
		return angle + 2 * PI
	elif angle > 2 * PI:
		return angle - 2 * PI
	else:
		return angle

func __scale_gun_and_player() -> void:
	if rotation > 3 * PI / 2 || rotation < PI / 2:
		scale = GUN_RIGHT
		sprite_2d["scale"] = PLAYER_RIGHT
	else:
		scale = GUN_LEFT
		sprite_2d["scale"] = PLAYER_LEFT

