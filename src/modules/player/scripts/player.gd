extends VehicleBody3D

@export var engine_power := 3000.0
@export var brake_power := 9.0
@export var max_steer := 0.2
var has_package: bool = false

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
	elif Input.is_action_pressed("move_down"):
		if not Input.is_action_pressed("ui_select"):
			brake = 0.0
			engine_force = -engine_power * 0.6
	else:
		engine_force = 0.0
