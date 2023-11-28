extends Control

@onready var pausemenu = $"."
@onready var volumemenu = $Volume
@onready var room_manager = get_node("/root/World/RoomManager")


func _process(delta):
	if Input.is_action_pressed("ui_cancel"):
		pausemenu.visible = true
		get_tree().paused = true

func _on_resume_pressed():
	pausemenu.visible = false
	get_tree().paused = false

func _on_back_to_main_menu_pressed():
	pausemenu.visible = false
	get_tree().paused = false
	get_tree().change_scene_to_file("res://Menu/menu.tscn")

func _on_quit_pressed():
	get_tree().quit()

func _on_volume_pressed():
	$CenterContainer.visible = false
	$MarginContainer.visible = false
	volumemenu.visible = true

func _on_back_pressed():
	volumemenu.visible = false
	$CenterContainer.visible = true
	$MarginContainer.visible = true
	pausemenu.visible = true


func _on_save_pressed():
	var game_data = get_game_data()
	SaveSystem.save_game(SaveSystem.current_slot, game_data)
	
func get_game_data():
	var pebbles_instance = room_manager.pebbles
	var data = {
		"player_health": pebbles_instance.get_health(),
		"player_position": pebbles_instance.global_position,
		"fish_count": pebbles_instance.get_fish_count(),
		"current_room": room_manager.current_room
	}
	return data
