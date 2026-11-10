extends TopDownState
func process(_delta: float) -> void:
	if Input.get_vector("Left", "Right", "Up", "Down") != Vector2.ZERO:
		if Input.is_action_pressed("Shift"):
			transition_request.emit("RunningState")
		else:
			transition_request.emit("WalkingState")

func physics_process(_delta: float) -> void:
	body.velocity = body.velocity.move_toward(Vector2.ZERO, body.deaccel * _delta)
	body.move_and_slide()
