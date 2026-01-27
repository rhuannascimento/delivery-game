extends CharacterBody3D

@onready var player := $"../Player"
@onready var agent := $NavigationAgent3D

@export var speed := 5.0
@export var backoff_speed := 4.0
@export var backoff_distance := 2.0
@export var tilt_strength := 0.6
@export var tilt_lerp := 6.0
@export var rotation_lerp := 8.0

var start_position: Vector3
var is_backing_off := false
var backoff_start_position: Vector3

func _ready() -> void:
	start_position = global_position
	agent.target_position = player.global_position

func _physics_process(delta: float) -> void:
	if is_backing_off:
		var back_dir = -transform.basis.z
		back_dir.y = 0
		back_dir = back_dir.normalized()

		velocity.x = back_dir.x * backoff_speed
		velocity.z = back_dir.z * backoff_speed

		move_and_slide()
		_apply_slope_tilt(delta)

		if global_position.distance_to(backoff_start_position) >= backoff_distance:
			is_backing_off = false
			velocity = Vector3.ZERO

		return

	var target: Vector3

	if global_position.distance_to(player.global_position) < 10:
		target = player.global_position
	else:
		if global_position.distance_to(start_position) > 2:
			target = start_position
		else:
			velocity = Vector3.ZERO
			move_and_slide()
			_apply_slope_tilt(delta)
			return

	agent.target_position = target

	if agent.is_navigation_finished():
		velocity = Vector3.ZERO
		move_and_slide()
		_apply_slope_tilt(delta)
		return

	var next_pos = agent.get_next_path_position()

	var dir = next_pos - global_position
	dir.y = 0

	if dir.length() < 0.1:
		velocity = Vector3.ZERO
		move_and_slide()
		_apply_slope_tilt(delta)
		return

	dir = dir.normalized()

	var target_yaw = atan2(dir.x, dir.z)
	rotation.y = lerp_angle(rotation.y, target_yaw, delta * rotation_lerp)

	velocity.x = dir.x * speed
	velocity.z = dir.z * speed

	move_and_slide()
	_apply_slope_tilt(delta)
	_check_collisions()

func _apply_slope_tilt(delta: float) -> void:
	if not is_on_floor():
		rotation.x = lerp(rotation.x, 0.0, delta * tilt_lerp)
		return

	var floor_normal = get_floor_normal()

	var forward = -transform.basis.z
	forward.y = 0
	forward = forward.normalized()

	var target_pitch = -floor_normal.dot(forward) * tilt_strength

	rotation.x = lerp(rotation.x, target_pitch, delta * tilt_lerp)
	rotation.z = 0.0

func _check_collisions():
	for i in range(get_slide_collision_count()):
		var collision = get_slide_collision(i)
		if collision.get_collider() == player and not is_backing_off:
			player.drop_cargo()
			is_backing_off = true
			backoff_start_position = global_position
