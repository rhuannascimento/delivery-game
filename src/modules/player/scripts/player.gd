extends VehicleBody3D

@export var engine_power := 1200.0
@export var brake_power := 40.0
@export var max_steer := 0.5

func _physics_process(delta):
	var accelerate = Input.get_action_strength("ui_up") - Input.get_action_strength("ui_down")
	var steer = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")

	engine_force = accelerate * engine_power
	steering = steer * max_steer

	if Input.is_action_pressed("ui_select"):
		brake = brake_power
	else:
		brake = 0.0
