extends PlatformerState

func enter() -> void:
	print(name)
	body.jumps = 0

func process(_delta: float) -> void:
	if not body.is_on_floor():
		transition_request.emit("FallingState")
	elif body.consume_jump():
		transition_request.emit("JumpingState")
	elif body.input_dir.x != 0.0:
		transition_request.emit("WalkingState")

func physics_process(_delta: float) -> void:
	body.velocity.x = move_toward(body.velocity.x, 0, body.deaccel * _delta)
