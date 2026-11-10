extends CharacterBody2D

@export var target: Node2D
@export var speed: float = 200.0
@export var stopping_distance: float = 50.0

func _physics_process(delta: float) -> void:
	var direction := global_position.direction_to(target.global_position)
	var distance := global_position.distance_to(target.global_position)

	if distance > stopping_distance:
		velocity = direction * speed
	else:
		velocity = Vector2.ZERO

	move_and_slide()
