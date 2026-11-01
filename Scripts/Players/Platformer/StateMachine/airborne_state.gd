extends PlayerState
@export var max_jump_impulse: float = 600.0

func enter() -> void:
	body.center_of_mass_mode = RigidBody2D.CENTER_OF_MASS_MODE_CUSTOM
	body.center_of_mass = Vector2(0, -20)

func physics_process(delta: float) -> void:
	if body.get_contact_count() > 0:
		transition_request.emit("GroundedState")
		
	body.apply_torque(Input.get_axis("ui_left", "ui_right") * 6000)
	
	if Input.is_action_just_released("ui_accept"):
			if body.get_contact_count() == 0:
				body.apply_central_impulse(body.transform.y * max_jump_impulse)
