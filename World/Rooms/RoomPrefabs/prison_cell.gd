extends Node2D

@export var next_room_path: String = "res://World/Rooms/RoomPrefabs/starting_room.tscn"
@export var open_door_map_texture: Texture2D
@onready var map_sprite: Sprite2D = $MapSprite
@onready var door_interactable_button: Sprite2D = $DoorInteractableArea/Button
@onready var door_interactable_animation_player: AnimationPlayer = $DoorInteractableArea/AnimationPlayer

var player_in_door_area: bool = false

func _ready():
	door_interactable_animation_player.play("hover")

func _physics_process(_delta):
	if player_in_door_area:
		if Input.is_action_just_pressed("interact"):
			next_scene_transition()
		door_interactable_button.visible = true
	else:
		door_interactable_button.visible = false

func _on_door_interactable_area_body_entered(body):
	if body.name == "Pebbles": 
		player_in_door_area = true

func _on_door_interactable_area_body_exited(body):
	if body.name == "Pebbles": 
		player_in_door_area = false

func next_scene_transition() -> void:
	map_sprite.texture = open_door_map_texture
	RoomManager.switch_room(next_room_path)
