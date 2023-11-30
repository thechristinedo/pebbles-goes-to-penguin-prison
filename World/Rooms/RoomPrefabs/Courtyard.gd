extends Node2D

@export var open_door_map_texture: Texture2D
@onready var map_sprite: Sprite2D = $MapSprite
@onready var enemies_container: Node2D = $Enemies
@onready var victory_scene: CanvasLayer = load("res://GUI/User Interface/UI_menu_scenes/victory_screen.tscn").instantiate()

var player_in_door_area: bool = false
var room_start_with_enemies: bool = false
var door_opened: bool = true

func _ready():
	if !no_more_enemies(): 
		room_start_with_enemies = true
		door_opened = false

func _physics_process(_delta):
	if !door_opened and room_start_with_enemies and no_more_enemies():
		door_opened = true
		map_sprite.texture = open_door_map_texture
	if door_opened:
		next_scene_transition()

func _on_door_interactable_area_body_entered(body):
	if body.name == "Pebbles": 
		player_in_door_area = true

func _on_door_interactable_area_body_exited(body):
	if body.name == "Pebbles": 
		player_in_door_area = false

func next_scene_transition() -> void:
	map_sprite.texture = open_door_map_texture
	get_tree().paused = true
	add_child(victory_scene)
	victory_scene.visible = true

func no_more_enemies() -> bool:
	return enemies_container.get_child_count() == 0
