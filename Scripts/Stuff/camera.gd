extends Camera2D

@export var parent: Node2D
@export var speed: float = 100

func _process(delta: float) -> void:
	global_position = global_position.lerp(
		parent.global_position,
		1.0 - exp(-speed * delta)
	)
