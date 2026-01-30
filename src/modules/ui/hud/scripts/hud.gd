extends CanvasLayer

@onready var label_tempo: Label = $Control/TimerLabel
@onready var label_score: Label = $Control/ScoreLabel
@onready var label_vida: Label = $Control/LifeLabel
@onready var timer: Timer = $Timer


var tempo_restante: int = 60 * 6 

var victory_score = 5
var current_score = -1

var max_hits = 10
var current_hits = 0

func _ready() -> void:
	add_to_group("game_manager")
	atualizar_timer()
	atualizar_vida_ui()
	atualizar_score()
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
	label_score.text = "Entregas: %d / %d" % [current_score, victory_score]

func atualizar_vida_ui() -> void:
	label_vida.text = "Vidas: %d" % (max_hits - current_hits)

func game_over() -> void:
	get_tree().change_scene_to_file("res://src/modules/ui/defeat/Defeat.tscn")

func registrar_dano():
	current_hits += 1
	print("Dano recebido! Total: ", current_hits)
	
	atualizar_vida_ui() 
	
	if current_hits >= max_hits:
		game_over()
