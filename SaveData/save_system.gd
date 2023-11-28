# save_system.gd
extends Node

#const SAVE_PATH = "user://"

func save_game(slot, data):
	print("Saved data in " + str(slot) + " and our data is ")
	print(data)
	var save_path = "user://save_slot_" + str(slot) + ".save"
	var save_file = FileAccess.open(save_path, FileAccess.WRITE)  # Updated for Godot 4.0
	if save_file:
		save_file.store_var(data)
		save_file.close()

func load_game(slot):
	var save_path = "user://save_slot_" + str(slot) + ".save"
	if FileAccess.file_exists(save_path):
		print("Loading Game on Slot " + str(slot))
		var save_file = FileAccess.open(save_path, FileAccess.READ)  # Updated for Godot 4.0
		if save_file:
			var data = save_file.get_var()
			save_file.close()
			return data
	return null

func slot_has_data(slot):
	var save_path = "user://save_slot_" + str(slot) + ".save"
	print("Already had saved data in Slot " + str(slot))
	return FileAccess.file_exists(save_path)

#func delete_save(slot):
#    var path = SAVE_PATH + "save_slot_" + str(slot) + ".save"
#    var save_file = File.new()
#    if save_file.file_exists(path):
#        save_file.remove(path)
#
