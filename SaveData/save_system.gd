# save_system.gd
extends Node

#const SAVE_PATH = "user://"
var current_slot = null

func save_game(slot, data):
	current_slot = slot
	print("Saved data in " + str(slot) + " and our data is ")
	print(data)
	var save_path = "user://save_slot_" + str(slot) + ".save"
	var save_file = FileAccess.open(save_path, FileAccess.WRITE)  # Updated for Godot 4.0
	if save_file:
		save_file.store_var(data)
		save_file.close()

func load_game(slot):
	current_slot = slot
	var save_path = "user://save_slot_" + str(slot) + ".save"
	if FileAccess.file_exists(save_path):
		print("Loading Game on Slot " + str(slot))
		var save_file = FileAccess.open(save_path, FileAccess.READ)  # Updated for Godot 4.0
		if save_file:
			var data = save_file.get_var()
			save_file.close()
			apply_game_data(data)
	return null

func slot_has_data(slot):
	current_slot = slot
	var save_path = "user://save_slot_" + str(slot) + ".save"
	print("Already had saved data in Slot " + str(slot))
	return FileAccess.file_exists(save_path)

#func delete_save(slot):
#    var path = SAVE_PATH + "save_slot_" + str(slot) + ".save"
#    var save_file = File.new()
#    if save_file.file_exists(path):
#        save_file.remove(path)
#

		
func apply_game_data(data):
	var world_scene_path = "res://World/world.tscn"
	if get_tree().current_scene.name != world_scene_path:
		var world_scene = load(world_scene_path) as PackedScene
		var world_instance = world_scene.instantiate()
		get_tree().root.add_child(world_instance)
		get_tree().current_scene = world_instance
		
	RoomManager.switch_room(data["current_room"])

	var player = RoomManager.pebbles
	var fishventory = player.find_child("Fishventory")
	if data["fish_items"]:
		data["fish_items"] = fishventory.deserialize(data["fish_items"])
	player.saved_fish_count = data["fish_count"]
	player.health = data["player_health"]
	player.global_position = data["player_position"]

	
	#player.set_new_data(data["fish_item"])
	print("Applying data: ", str(player))
	print("Set player health to: ", player.get_health())
	#player.fish_count = data["fish_count"]
	#player.global_position = data["player_position"

