extends Area3D


@export var pickup_point: Area3D

func _on_body_entered(body: Node3D) -> void:
	if body.is_in_group("player"):
		var success =  body.delivery_cargo()
		
		if success:
			queue_free()
			pickup_point.show_point()
			
