extends CanvasLayer

@onready var label_tempo: Label = $Control/TimerLabel
@onready var label_score: Label = $Control/ScoreLabel
@onready var timer: Timer = $Timer


var tempo_restante: int = 120 

var victory_score = 5
var current_score = 0

func _ready() -> void:
	atualizar_timer()
	label_score.text = "%d / %d" % [current_score, victory_score]
	timer.timeout.connect(_on_timer_timeout)

func _on_timer_timeout() -> void:
	tempo_restante -= 1
	atualizar_timer()
	
	if tempo_restante <= 0:
		timer.stop()
		game_over()

func atualizar_timer() -> void:
	var minutos = tempo_restante / 60
	var segundos = tempo_restante % 60
	
	label_tempo.text = "%02d:%02d" % [minutos, segundos]
	
	
func atualizar_score() -> void:
	current_score += 1
	label_score.text = "%d / %d" % [current_score, victory_score]
	
	
	

func game_over() -> void:
	get_tree().change_scene_to_file("res://src/modules/ui/defeat/Defeat.tscn")
