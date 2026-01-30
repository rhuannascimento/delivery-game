extends Control

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	$Container/PlayButton.grab_focus()

func _on_play_button_pressed():
	# tocar som de tick e esperar breve antes de mudar de cena
	if has_node('TickSound'):
		$TickSound.play()
	await get_tree().create_timer(0.12).timeout
	get_tree().change_scene_to_file("res://src/Main.tscn")

func _on_quit_button_pressed():
	# tocar som de tick antes de sair
	if has_node('TickSound'):
		$TickSound.play()
	await get_tree().create_timer(0.12).timeout
	get_tree().quit()


func _on_credit_button_pressed() -> void:
	if has_node('TickSound'):
		$TickSound.play()
	await get_tree().create_timer(0.12).timeout
	get_tree().change_scene_to_file("res://src/modules/ui/credit/Credit.tscn")
