extends PlayerState

@export var min_jump_impulse: float = 200.0
@export var max_jump_impulse: float = 400.0
@export var max_charge_time: float = 1.0
@export var lean_torque: float = 7500.0

var charge_time := 0.0


func enter() -> void:
	charge_time = 0.0
	body.center_of_mass_mode = RigidBody2D.CENTER_OF_MASS_MODE_CUSTOM
	body.center_of_mass = Vector2(0, 30)
	body.angular_damp = 3.0


func physics_process(delta: float) -> void:
	if (body.get_contact_count() == 0):
		transition_request.emit("AirborneState")
	
	body.apply_torque(Input.get_axis("ui_left", "ui_right") * lean_torque)
	
	if Input.is_action_pressed("ui_accept"):
		charge_time = minf(charge_time + delta, max_charge_time)
		
	elif Input.is_action_just_released("ui_accept"):
		if body.get_contact_count() > 0:
			var t := charge_time / max_charge_time
			body.apply_central_impulse(-body.transform.y * lerpf(min_jump_impulse, max_jump_impulse, t))
			
			SfxManager.play("jump")
			
		charge_time = 0.0
		
