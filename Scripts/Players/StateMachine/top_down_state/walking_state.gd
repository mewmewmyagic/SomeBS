extends TopDownState

var input_dir: Vector2

func process(_delta: float) -> void:
	body.play_footsteps(0.9, 1.1)
	if Input.is_action_pressed("Shift"):
		transition_request.emit("RunningState")
		return
	if body.velocity.is_zero_approx():
		transition_request.emit("IdleState")
		return
	

func physics_process(delta: float) -> void:
	if input_dir != Vector2.ZERO:
		body.velocity = body.velocity.move_toward(input_dir * body.walk_speed, body.accel * delta)
	else:
		body.velocity = body.velocity.move_toward(Vector2.ZERO, body.deaccel * delta)
		
	body.move_and_slide()
	
func _unhandled_input(event: InputEvent) -> void:
	input_dir = Vector2.ZERO

	if Input.is_action_pressed("Up"):
		input_dir.y = -1
	if Input.is_action_pressed("Down"):
		input_dir.y = 1
	if Input.is_action_pressed("Left"):
		input_dir.x = -1
	if Input.is_action_pressed("Right"):
		input_dir.x = 1

	input_dir = input_dir.normalized()
