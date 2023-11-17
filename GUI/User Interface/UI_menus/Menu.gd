extends Control

@onready var main_label = $CenterContainer
@onready var main_buttons = $MarginContainer

@onready var option_menu = $Option
@onready var volume_menu = $Volume
@onready var input_type_menu = $InputType
@onready var selectSound = $selectSound
@onready var saveslot = $SaveSlot

func _on_play_pressed():
	#$TextureRect.visible = true
	selectSound.play()
	
	#SceneTransition.change_scene("res://Levels/prison_level.tscn", 'dissolve')
	main_label.visible = false
	main_buttons.visible = false
	saveslot.visible = true

func _on_save_slot_1_pressed():
	#$TextureRect.visible = true
	get_tree().change_scene_to_file("res://Intro/intro_cutscene.tscn")
	selectSound.play()

func _on_save_slot_2_pressed():
	#$TextureRect.visible = true
	selectSound.play()
	get_tree().change_scene_to_file("res://Intro/intro_cutscene.tscn")
	#SceneTransition.change_scene("res://World/world.tscn", 'dissolve')

func _on_save_slot_3_pressed():
	#$TextureRect.visible = true
	selectSound.play()
	get_tree().change_scene_to_file("res://Intro/intro_cutscene.tscn")
	#SceneTransition.change_scene("res://World/world.tscn", 'dissolve')

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
	
func _on_input_type_pressed():
	selectSound.play()
	option_menu.visible = false
	input_type_menu.visible = true

func _on_back_pressed():
	selectSound.play()
	main_label.visible = true
	main_buttons.visible = true
	option_menu.visible = false
	volume_menu.visible = false
	input_type_menu.visible = false
	saveslot.visible = false


func _on_input_type_button_item_selected(index):
	pass # Replace with function body.
