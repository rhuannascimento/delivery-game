extends VehicleBody3D

@export var engine_power := 2700.0
@export var brake_power := 9.0
@export var max_steer := 0.35
var has_package: bool = false
@export var crash_sound: AudioStream
@onready var _crash_player: AudioStreamPlayer3D = $CrashSound
@onready var _engine_player: AudioStreamPlayer3D = $EngineSound
@onready var _horn_player: AudioStreamPlayer3D = $HornSound
@onready var _reverse_player: AudioStreamPlayer3D = $ReverseSound

func _ready() -> void:
	if has_node('cargo'):
		$cargo.visible = false

	# conecta o sinal da área de colisão para tocar som
	if has_node('CollisionArea'):
		$CollisionArea.body_entered.connect(Callable(self, "_on_CollisionArea_body_entered"))
	# aplica o áudio exportado ao player (opcional)
	if crash_sound != null:
		_crash_player.stream = crash_sound
	else:
		# tenta carregar automaticamente o som de colisão padrão
		var crash_path := "res://assets/sounds/car-crash-sound-376882.ogg"
		var stream = ResourceLoader.load(crash_path)
		if stream:
			_crash_player.stream = stream

	# tenta carregar engine automaticamente (se não definido no nó)
	if not _engine_player.stream:
		var engine_path := "res://assets/sounds/engine-6000.ogg"
		var est = ResourceLoader.load(engine_path)
		if est:
			_engine_player.stream = est
		
func collect_cargo():
	if has_package == false:
		has_package = true
		$cargo.visible = true
		# tocar buzina ao pegar a caixa
		# parar som de colisão se estiver tocando e garantir buzina correta
		if _crash_player and _crash_player.playing:
			_crash_player.stop()
		if _engine_player and _engine_player.playing:
			_engine_player.stop()
		if _reverse_player and _reverse_player.playing:
			_reverse_player.stop()
		if _horn_player and _horn_player.stream:
			_horn_player.play()
			
func delivery_cargo():
	if has_package == true:
		has_package = false
		$cargo.visible = false
		# tocar buzina ao entregar a caixa
		# parar som de colisão se estiver tocando e garantir buzina correta
		if _crash_player and _crash_player.playing:
			_crash_player.stop()
		if _engine_player and _engine_player.playing:
			_engine_player.stop()
		if _reverse_player and _reverse_player.playing:
			_reverse_player.stop()
		if _horn_player and _horn_player.stream:
			_horn_player.play()
		return true
	return false

func _physics_process(delta):
	var steer = Input.get_action_strength("move_left") - Input.get_action_strength("move_right")
	steering = steer * max_steer

	if Input.is_action_pressed("ui_select"):
		brake = brake_power
		engine_force = 0.0
	
	if Input.is_action_pressed("move_up"):
		if not Input.is_action_pressed("ui_select"):
			brake = 0.0
			engine_force = engine_power
			# tocar som de motor enquanto acelera
			if _engine_player and _engine_player.stream:
				if not _engine_player.playing:
					_engine_player.play()
				# usar pitch fixo sequencial (antiga lógica de ré)
				_engine_player.pitch_scale = 0.6
				# garantir que o som de ré não esteja tocando
				if _reverse_player and _reverse_player.playing:
					_reverse_player.stop()
	elif Input.is_action_pressed("move_down"):
		if not Input.is_action_pressed("ui_select"):
			brake = 0.0
			engine_force = -engine_power * 0.85
			# tocar som específico de ré
			if _reverse_player and _reverse_player.stream:
				if not _reverse_player.playing:
					_reverse_player.play()
				var ratio: float = float(abs(engine_force)) / float(max(1.0, engine_power))
				_reverse_player.pitch_scale = 0.8 + clamp(ratio, 0.0, 1.5)
				# garantir que o som de motor para frente não esteja tocando
				if _engine_player and _engine_player.playing:
					_engine_player.stop()
	else:
		engine_force = 0.0
		# parar som do motor quando não estiver acelerando
		if _engine_player and _engine_player.playing:
			_engine_player.stop()


func _on_CollisionArea_body_entered(body: Node3D) -> void:
	# ignora outras instâncias do jogador e áreas (pontos de pickup/delivery)
	if body.is_in_group('player'):
		return
	if body is Area3D:
		return

	# toca o som de batida (se não estiver tocando)
	if _crash_player and _crash_player.stream:
		_crash_player.play()
