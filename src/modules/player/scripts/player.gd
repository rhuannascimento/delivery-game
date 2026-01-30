extends VehicleBody3D

@export var engine_power := 2700.0
@export var brake_power := 9.0
@export var max_steer := 0.35

@export var reset_force := 5.0 
@export var reset_cooldown := 1.0 
var time_since_reset := 0.0

var has_package: bool = false

signal cargo_delivered

func _ready() -> void:
	if has_node('cargo'):
		$cargo.visible = false
		
func collect_cargo():
	if has_package == false:
		has_package = true
		$cargo.visible = true
			
func delivery_cargo():
	if has_package == true:
		has_package = false
		$cargo.visible = false
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
	elif Input.is_action_pressed("move_down"):
		if not Input.is_action_pressed("ui_select"):
			brake = 0.0
			engine_force = -engine_power * 0.85
	else:
		engine_force = 0.0
	
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
