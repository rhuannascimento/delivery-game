extends Control

@onready var victory_song = $SFX_Victory

func _ready():
	$Container/TryAgainButton.grab_focus()
	victory_song.play();

func _on_try_again_button_pressed() -> void:
	get_tree().change_scene_to_file("res://src/Main.tscn")


func _on_back_to_menu_button_pressed() -> void:
	get_tree().change_scene_to_file("res://src/modules/ui/menu/Menu.tscn")
