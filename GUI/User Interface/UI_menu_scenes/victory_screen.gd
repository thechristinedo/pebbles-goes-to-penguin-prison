extends CanvasLayer

@onready var victory_sound = $VictorySound

func _ready():
	# Play the victory sound when the scene is ready
	victory_sound.play()

func _on_play_again_pressed():
	get_tree().paused = false
	#SceneTransition.change_scene("res://Levels/prison_level.tscn", 'dissolve')
	get_tree().change_scene_to_file("res://World/world.tscn")

func _on_quit_pressed():
	get_tree().quit()


func _on_back_to_main_menu_pressed():
	get_tree().paused = false
	get_tree().change_scene_to_file("res://Menu/menu.tscn")
