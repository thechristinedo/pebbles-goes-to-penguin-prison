extends Sprite2D


@export var sprite_2d: Sprite2D
@export var player_path: String = "/root/PrisonLevel/Pebbles"

var player: Node2D  # Define player at the class level

const GUN_LEFT: Vector2 = Vector2(1, -1)
const GUN_RIGHT: Vector2 = Vector2(1, 1)

func _ready():
	player = get_parent().get_node(player_path)  # Assign the correct node to player

func _physics_process(_delta):
	rotation = __wrap(rotation)
	
	if player:
		look_at(player.global_position)
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
	else:
		scale = GUN_LEFT
