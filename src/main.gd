extends Node3D
var target_score: int = 1
var current_score: int = 0



func check_win_condition():
	if current_score >= target_score:
		get_tree().change_scene_to_file("res://src/modules/ui/victory/Victory.tscn")
		


func _on_player_cargo_delivered() -> void:
	current_score += 1
	print('currentScore: ', current_score)
	check_win_condition()
