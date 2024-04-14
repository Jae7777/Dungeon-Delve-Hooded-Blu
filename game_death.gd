extends Control
var restart_button
var quit_button
var start_level = preload("res://level_start.tscn")

func _ready():
	restart_button = $VBoxContainer/RestartButton
	quit_button = $VBoxContainer/QuitButton
	
	restart_button.button_down.connect(on_restart_pressed)
	quit_button.button_down.connect(on_quit_pressed)

func on_restart_pressed():
	get_tree().change_scene_to_packed(start_level)

func on_quit_pressed():
	get_tree().quit()
