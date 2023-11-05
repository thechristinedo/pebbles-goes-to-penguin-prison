extends Node

@export var next_room: String

func _process(_delta) -> void:
	if Input.is_action_just_pressed("ui_accept"):
		RoomManager.switch_room(next_room)
