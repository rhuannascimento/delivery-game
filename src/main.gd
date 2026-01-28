extends Node2D

@onready var _music_player: AudioStreamPlayer = $MusicPlayer
var _music_on: bool = true

func _ready() -> void:
	# garante que comece com música ligada
	if _music_player and _music_player.stream:
		if not _music_player.playing:
			_music_player.play()

func _input(event: InputEvent) -> void:
	# alterna música via ação `toggle_music`
	if event.is_action_pressed("toggle_music"):
		_toggle_music()

func _toggle_music() -> void:
	if not _music_player:
		return
	if _music_player.playing:
		_music_player.stop()
		_music_on = false
	else:
		_music_player.play()
		_music_on = true
