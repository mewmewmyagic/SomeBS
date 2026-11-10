extends PlatformerState

var coyote_timer := 0.0


var max_speed: float
func enter() -> void:
	max_speed = body.run_speed

func process(delta: float) -> void:
	if body.is_on_floor():
		coyote_timer = 0.0
	else:
		coyote_timer += delta

	if body.consume_jump():
		transition_request.emit("JumpingState")
	elif coyote_timer > body.coyote_time:
		transition_request.emit("FallingState")
		
	elif not body.run_held and body.input_dir.x != 0:
		transition_request.emit("WalkingState")
	elif body.input_dir.x == 0.0:
		transition_request.emit("IdleState")

func physics_process(delta: float) -> void:
	body.velocity.x = move_toward(body.velocity.x, body.input_dir.x * max_speed, body.accel * delta)
	body.move_and_slide()
