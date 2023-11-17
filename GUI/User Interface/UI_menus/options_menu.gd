extends Control

func _on_back_pressed():
	get_tree().change_scene_to_file("res://Menu/menu.tscn")


func _on_volume_pressed():
	get_tree().change_scene_to_file("res://volume_menu.tscn")


func _on_input_type_pressed():
	get_tree().change_scene_to_file("res://GUI/User Interface/UI_menu_scenes/input_type_menu.tscn")
