extends Node2D

@export var rotation_speed: float = 10.0

func _process(delta: float) -> void:
	var target := (get_global_mouse_position() - global_position).angle()
	rotation = lerp_angle(rotation, target, 1.0 - exp(-rotation_speed * delta))
