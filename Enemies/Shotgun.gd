extends Sprite2D


@export var sprite_2d: Sprite2D
@export var player_path: String = "/root/PrisonLevel/Pebbles"

var player: Node2D  # Define player at the class level

const GUN_LEFT: Vector2 = Vector2(1, -1)
const GUN_RIGHT: Vector2 = Vector2(1, 1)

func _ready():
	player = get_parent().get_node(player_path)  # Assign the correct node to player

func _physics_process(_delta):
	if player:
		look_at(player.global_position)
