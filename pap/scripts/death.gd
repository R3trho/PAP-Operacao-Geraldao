extends Control

var is_paused = false

func Restart():
	TogglePaused()
	get_tree().reload_current_scene()
	
	
func Exit():
	TogglePaused()
	get_tree().change_scene_to_file("res://scenes/maincode.tscn")



func TogglePaused():
	is_paused = !is_paused
		
	get_tree().paused = is_paused
	self.is_paused = is_paused
	
	visible = is_paused


func _on_restart_pressed():
	get_tree().reload_current_scene()


func _on_quit_pressed():
	get_tree().quit()
