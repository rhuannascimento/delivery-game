extends Camera3D

@export var target: Node3D
@export var offset := Vector3(0, 5, 10)

func _process(delta):
	if target:
		global_position = target.global_position + offset
		look_at(target.global_position, Vector3.UP)
