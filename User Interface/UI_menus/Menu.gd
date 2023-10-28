extends Control

@onready var main_label = $CenterContainer
@onready var main_buttons = $MarginContainer

@onready var option_menu = $Option
@onready var volume_menu = $Volume
@onready var selectSound = $selectSound

func _on_play_pressed():
	#$TextureRect.visible = true
	selectSound.play()
	
	SceneTransition.change_scene("res://Levels/prison_level.tscn", 'dissolve')

func _on_options_pressed():
	selectSound.play()
	main_label.visible = false
	main_buttons.visible = false
	option_menu.visible = true
	#get_tree().change_scene_to_file("res://options_menu.tscn")

func _on_exit_pressed():
	selectSound.play()
	get_tree().quit()

func _on_volume_pressed():
	selectSound.play()
	option_menu.visible = false
	volume_menu.visible = true
	

func _on_back_pressed():
	selectSound.play()
	main_label.visible = true
	main_buttons.visible = true
	option_menu.visible = false
	volume_menu.visible = false
