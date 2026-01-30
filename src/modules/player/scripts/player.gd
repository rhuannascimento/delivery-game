extends VehicleBody3D

@export var engine_power := 2700.0
@export var brake_power := 9.0
@export var max_steer := 0.35

@export var reset_force := 5.0 
@export var reset_cooldown := 1.0 
var time_since_reset := 0.0

var has_package: bool = false
@export var crash_sound: AudioStream

@export var min_pitch := 0.6
@export var max_pitch := 2.0 
@export var pitch_speed_scale := 30.0

@onready var _crash_player: AudioStreamPlayer3D = $CrashSound
@onready var _engine_player: AudioStreamPlayer3D = $EngineSound
@onready var _horn_player: AudioStreamPlayer3D = $HornSound
@onready var _reverse_player: AudioStreamPlayer3D = $ReverseSound

signal cargo_delivered

func _ready() -> void:
	if has_node('cargo'):
		$cargo.visible = false

	if has_node('CollisionArea'):
		$CollisionArea.body_entered.connect(Callable(self, "_on_CollisionArea_body_entered"))
	
	if crash_sound != null:
		_crash_player.stream = crash_sound
	else:
		var crash_path := "res://assets/sounds/car-crash-sound-376882.ogg"
		if ResourceLoader.exists(crash_path):
			_crash_player.stream = ResourceLoader.load(crash_path)

	if not _engine_player.stream:
		var engine_path := "res://assets/sounds/engine-6000.ogg"
		if ResourceLoader.exists(engine_path):
			_engine_player.stream = ResourceLoader.load(engine_path)
	
	if _engine_player.stream:
		_engine_player.play()

func collect_cargo():
	if has_package == false:
		has_package = true
		$cargo.visible = true
		if _crash_player and _crash_player.playing:
			_crash_player.stop()
		if _reverse_player and _reverse_player.playing:
			_reverse_player.stop()
		if _horn_player and _horn_player.stream:
			_horn_player.play()
			
func delivery_cargo():
	if has_package == true:
		has_package = false
		$cargo.visible = false
		if _crash_player and _crash_player.playing:
			_crash_player.stop()
		if _reverse_player and _reverse_player.playing:
			_reverse_player.stop()
		if _horn_player and _horn_player.stream:
			_horn_player.play()
		
		cargo_delivered.emit()
		return true
	return false

func drop_cargo():
	if has_package == true:
		has_package = false
		$cargo.visible = false

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
			
			if _reverse_player and _reverse_player.playing:
				_reverse_player.stop()
				
	elif Input.is_action_pressed("move_down"):
		if not Input.is_action_pressed("ui_select"):
			brake = 0.0
			engine_force = -engine_power * 0.85
			
			if _reverse_player and _reverse_player.stream:
				if not _reverse_player.playing:
					_reverse_player.play()
	else:
		engine_force = 0.0
		if _reverse_player and _reverse_player.playing:
			_reverse_player.stop()

	if _engine_player.stream:
		var current_speed = linear_velocity.length()
		
		var target_pitch = min_pitch + (current_speed / pitch_speed_scale)
		
		target_pitch = clamp(target_pitch, min_pitch, max_pitch)
		
		_engine_player.pitch_scale = lerp(_engine_player.pitch_scale, target_pitch, delta * 5.0)

	time_since_reset += delta
	if Input.is_key_pressed(KEY_R) and time_since_reset > reset_cooldown:
		_unstuck_car()
		time_since_reset = 0.0

func _unstuck_car():
	angular_velocity = Vector3.ZERO
	linear_velocity = Vector3.ZERO
	global_position.y += 1.0
	rotation.x = 0 
	rotation.z = 0
	var impulso = (Vector3.UP * 1.5 + Vector3.RIGHT * 0.5).normalized()
	apply_central_impulse(impulso * mass * reset_force)

func _on_CollisionArea_body_entered(body: Node3D) -> void:
	if body.is_in_group('player'):
		return
	if body is Area3D:
		return

	if _crash_player and _crash_player.stream:
		_crash_player.play()
