extends Node3D

@export var distance := 5.0
@export var height := 1.0
@export var mouse_sensitivity := 0.003
@export var min_pitch := -0.3
@export var max_pitch := 0.5
@export var smooth_speed := 10.0
@export var collision_margin := 0.1
@export var min_distance := 1.5

var yaw := 0.0
var pitch := 0.15

@onready var cam: Camera3D = $Camera3D
@onready var ray: RayCast3D = $RayCast3D

func _ready():
	var dir = _get_orbit_direction()
	cam.global_position = global_position + dir * distance + Vector3.UP * height
	cam.look_at(global_position, Vector3.UP)

func _unhandled_input(event):
	if event is InputEventMouseMotion:
		yaw -= event.relative.x * mouse_sensitivity
		pitch += event.relative.y * mouse_sensitivity
		pitch = clamp(pitch, min_pitch, max_pitch)

func _process(delta):
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	var dir = _get_orbit_direction()
	var desired_pos = global_position + dir * distance + Vector3.UP * height

	ray.global_position = global_position + Vector3.UP * height
	ray.target_position = ray.to_local(desired_pos)
	ray.force_raycast_update()

	var final_pos = desired_pos

	if ray.is_colliding():
		var hit_point = ray.get_collision_point()
		var cam_dir = (desired_pos - ray.global_position).normalized()
		var hit_dist = ray.global_position.distance_to(hit_point)

		if hit_dist > min_distance:
			final_pos = ray.global_position + cam_dir * (hit_dist - collision_margin)

	cam.global_position = cam.global_position.lerp(
		final_pos,
		smooth_speed * delta
	)

	cam.look_at(global_position + Vector3.UP * height, Vector3.UP)

func _get_orbit_direction() -> Vector3:
	return Vector3(
		cos(pitch) * sin(yaw),
		sin(pitch),
		cos(pitch) * cos(yaw)
	).normalized()
