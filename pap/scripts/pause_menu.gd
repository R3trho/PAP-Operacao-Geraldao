extends Control

var is_paused = false

func _input(event):
	if event.is_action_pressed("esc"):
		TogglePaused()

func Resume():
	TogglePaused()

func Restart():
	Resume()
	get_tree().reload_current_scene()

func Exit():
	TogglePaused()
	
	get_tree().change_scene_to_file("res://Scenes/Main_Menu.tscn")

func TogglePaused():
	is_paused = !is_paused
		
	get_tree().paused = is_paused
	self.is_paused = is_paused
	
	visible = is_paused
