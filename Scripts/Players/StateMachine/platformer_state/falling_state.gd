extends PlatformerState

func enter() -> void:
	print(name)

func process(_delta: float) -> void:
	if body.is_on_floor():
		transition_request.emit("IdleState")
	elif body.consume_jump() and body.jumps <= body.double_jumps:
		transition_request.emit("JumpingState")
	elif body.is_on_wall():
		transition_request.emit("WallState")

func physics_process(delta: float) -> void:
	var over_speed := body.input_dir.x == 0.0 or signf(body.velocity.x) == signf(body.input_dir.x) and absf(body.velocity.x) > body.walk_speed
	if not over_speed:
		body.velocity.x = move_toward(body.velocity.x, body.input_dir.x * body.walk_speed, body.accel * delta)
	body.velocity += body.get_gravity() * delta
	body.move_and_slide()
