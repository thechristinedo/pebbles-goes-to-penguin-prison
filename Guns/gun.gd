extends Sprite2D

@export var sprite_2d: Sprite2D
@export var player: CharacterBody2D

const GUN_LEFT: Vector2 = Vector2(1, -1)
const GUN_RIGHT: Vector2 = Vector2(1, 1)

const PLAYER_LEFT: Vector2 = Vector2(-1, 1)
const PLAYER_RIGHT: Vector2 = Vector2(1, 1)

func _physics_process(_delta):
	var center = get_viewport_rect().size / 2
	var mouse = get_viewport().get_mouse_position()
	rotation = atan2(mouse.y - center.y, mouse.x - center.x)
	if rotation < PI / 2 && rotation > -PI / 2:
		scale = GUN_RIGHT
		sprite_2d["scale"] = PLAYER_RIGHT
	else:
		scale = GUN_LEFT
		sprite_2d["scale"] = PLAYER_LEFT

func shooting():
	pass
