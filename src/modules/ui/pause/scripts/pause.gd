extends Control

func _ready():
	visible = false
	get_tree().paused = false
	$Container/ReturnButton.grab_focus()

func _input(event):
	if event.is_action_pressed("ui_cancel"):
		alternar_pause()

func alternar_pause():
	var estado_atual = get_tree().paused
	get_tree().paused = not estado_atual
	
	visible = not estado_atual
	
	if estado_atual:
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	else:
		Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	

func _on_return_button_pressed() -> void:
	alternar_pause()


func _on_back_to_menu_button_pressed() -> void:
	alternar_pause()
	get_tree().change_scene_to_file("res://src/modules/ui/menu/Menu.tscn")
