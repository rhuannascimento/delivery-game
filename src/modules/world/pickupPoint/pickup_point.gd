extends Area3D

@export var delivery_points: Array[Area3D]
func _ready() -> void:
	add_to_group("pontos_coleta")
	pass 

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

func _on_body_entered(body: Node3D) -> void:
	if body.is_in_group('player'):
		body.collect_cargo()
		hide_point()
		
		
		
func show_point():
	visible = true
	monitoring = true 

func hide_point():
	visible = false
	monitoring = false # Volta a detectar colisão
