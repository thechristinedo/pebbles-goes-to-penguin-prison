extends Node
class_name World

@onready var player = load("res://Entities/Player/pebbles.tscn").instantiate()
@onready var player_health_bar_ui = $GUI/Panel/HeartsContainer
#@onready var player_ammo_ui = $"GUI/Panel/Ammo Amount"

@onready var fish_count_ui = $GUI/Panel/FishAmount

# Controller compatibility
enum INPUT_SCHEMES { KEYBOARD_AND_MOUSE, GAMEPAD }
static var INPUT_SCHEME: INPUT_SCHEMES = INPUT_SCHEMES.KEYBOARD_AND_MOUSE

func _ready():
	init_room()
	$intenseMusic.play()
	player.health_updated.connect(player_health_bar_ui.set_health)
	#player.pebbles_shoot.connect(player_ammo_ui.set_ammo_amount)
	
	# health bar needs to be initialized here for some reason
#	player.emit_signal("health_updated", player.max_health, player.max_health)
	player.health_updated.emit(player.max_health, player.max_health)
	#player.emit_signal("pebbles_shoot", player.ammo)

func init_room() -> void:
	RoomManager.setup()
	RoomManager.switch_room(RoomManager.starting_room)
	

func _physics_process(_delta):
	pass

func update_player_health(health: int, max_health: int) -> void:
	player.health_updated.emit(health, max_health)
