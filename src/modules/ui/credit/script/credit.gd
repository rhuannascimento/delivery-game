extends Control


func _ready() -> void:
	$AnimationPlayer.play("credits")


func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	get_tree().change_scene_to_file("res://src/modules/ui/menu/MainMenu.tscn")
