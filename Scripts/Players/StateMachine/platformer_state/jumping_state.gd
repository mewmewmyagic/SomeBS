extends PlatformerState

func enter() -> void:
	body.velocity.y = -body.jump_velocity
	body.jumps += 1

func process(_delta: float) -> void:
	if body.consume_jump() and body.jumps <= body.double_jumps:
		enter()
	elif body.velocity.y >= 0.0:
		transition_request.emit("FallingState")

func physics_process(delta: float) -> void:
	var over_speed := body.input_dir.x == 0.0 or signf(body.velocity.x) == signf(body.input_dir.x) and absf(body.velocity.x) > body.walk_speed
	if not over_speed:
		body.velocity.x = move_toward(body.velocity.x, body.input_dir.x * body.walk_speed, body.accel * delta)
	body.velocity += body.get_gravity() * delta
	body.move_and_slide()
