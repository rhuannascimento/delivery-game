extends Control

func _ready():
	visible = false
	get_tree().paused = false
	$Container/ReturnButton.grab_focus()

func _input(event):
	if event.is_action_pressed("ui_cancel"):
		toggle_pause()

func toggle_pause():
	var actual_state = get_tree().paused
	get_tree().paused = not actual_state
	
	visible = not actual_state
	
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	

func _on_return_button_pressed() -> void:
	toggle_pause()


func _on_back_to_menu_button_pressed() -> void:
	toggle_pause()
	get_tree().change_scene_to_file("res://src/modules/ui/menu/Menu.tscn")
