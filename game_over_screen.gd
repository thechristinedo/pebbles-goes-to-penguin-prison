extends CanvasLayer


func _on_play_again_pressed():
	get_tree().paused = false
	get_tree().change_scene_to_file("res://Levels/prison_level.tscn")


func _on_quit_pressed():
	get_tree().quit()
