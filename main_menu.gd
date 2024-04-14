extends Control
var play_button
var credits_button
var quit_button
var start_level = load("res://level_start.tscn")

func _ready():
	play_button = $PlayButton
	credits_button = $CreditsButton
	quit_button = $QuitButton
	
	play_button.button_down.connect(on_play_pressed)
	credits_button.button_down.connect(on_credits_pressed)
	quit_button.button_down.connect(on_quit_pressed)

func on_play_pressed():
	get_tree().change_scene_to_packed(start_level)
	
func on_credits_pressed():
	OS.shell_open("https://docs.google.com/presentation/d/1JDMYT_WqfGfxOHIcOnSkw5AedU-LvnjWFznbWGXjS0M/edit#slide=id.g2cbfaa9decd_0_126")

func on_quit_pressed():
	get_tree().quit()
