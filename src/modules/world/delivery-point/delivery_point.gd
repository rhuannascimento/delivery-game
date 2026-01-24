extends Area3D




func _on_body_entered(body: Node3D) -> void:
	if body.is_in_group("player"):
		complete_delivery()



func complete_delivery() -> void: 
	print("Pacote entregue")
	
	queue_free()
	
	
	
