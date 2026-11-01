extends CharacterBody2D

@export var max_speed := 200.0

#kalau mau tidak akselerasi, acc dan fric kasih jauh lebih besar dari max speed
@export var acceleration := 320.0
@export var friction := 320.0
@export var sprite: Sprite2D

func _physics_process(delta: float) -> void:
	var dir := _read_input()

	if dir != Vector2.ZERO:
		velocity += dir * acceleration * delta
	else:
		velocity = velocity.move_toward(Vector2.ZERO, friction * delta)

	velocity = velocity.limit_length(max_speed)
	move_and_slide()
	
	for i in get_slide_collision_count():
		var collision = get_slide_collision(i)
		var body = collision.get_collider()

		if body is RigidBody2D:
			body.apply_central_impulse(-collision.get_normal() * 25)


func _read_input() -> Vector2:
	var dir := Vector2.ZERO

	if Input.is_action_pressed("Up"):
		dir.y = -1
	if Input.is_action_pressed("Down"):
		dir.y = 1
	if Input.is_action_pressed("Left"):
		dir.x = -1
	if Input.is_action_pressed("Right"):
		dir.x = 1

	return dir.normalized()
