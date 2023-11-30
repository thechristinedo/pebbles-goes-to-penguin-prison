extends Control

@onready var pausemenu = $"."
@onready var volumemenu = $Volume

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
	var pebbles_instance = RoomManager.pebbles
	var game_data = get_game_data()
	SaveSystem.save_game(SaveSystem.current_slot, game_data)
	
	
func get_game_data():
	var pebbles_instance = RoomManager.pebbles
	var fishventory= pebbles_instance.get_node("Fishventory")
	var data = {
		"player_health": pebbles_instance.get_health(),
		"player_position": pebbles_instance.global_position,
		"fish_count": pebbles_instance.get_fish_count(),
		"fish_items": fishventory.serialize(),
		"current_room": RoomManager.current_room_path,
		"weapons": pebbles_instance.get_inventory_data()
	}
	return data
