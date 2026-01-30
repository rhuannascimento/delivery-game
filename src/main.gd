extends Node3D

var victory_score: int = 5
var current_score: int = 0
var _music_on: bool = true

@onready var hud = $Hud
@onready var _music_player: AudioStreamPlayer = $MusicPlayer

func _ready() -> void:
	# garante que comece com música ligada
	if _music_player and _music_player.stream:
		if not _music_player.playing:
			_music_player.play()

func _input(event: InputEvent) -> void:
	# alterna música via ação `toggle_music`
	if event.is_action_pressed("toggle_music"):
		_toggle_music()

func check_win_condition():
	if current_score >= victory_score:
		get_tree().change_scene_to_file("res://src/modules/ui/victory/Victory.tscn")

func _on_player_cargo_delivered() -> void:
	current_score += 1
	hud.atualizar_score()
	check_win_condition()

func _toggle_music() -> void:
	if not _music_player:
		return
	if _music_player.playing:
		_music_player.stop()
		_music_on = false
	else:
		_music_player.play()
		_music_on = true
