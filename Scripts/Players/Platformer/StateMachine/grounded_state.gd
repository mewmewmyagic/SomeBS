extends PlayerState

@export var min_jump_impulse: float = 200.0
@export var max_jump_impulse: float = 400.0
@export var max_charge_time: float = 1.0
@export var lean_torque: float = 7500.0

var charge_time := 0.0
var jump_direction := Vector2.UP
var rotation_angle := 0.0


const ROTATION_SPEED := 90.0
const MAX_ANGLE := 30.0


func enter() -> void:
	charge_time = 0.0
	body.center_of_mass_mode = RigidBody2D.CENTER_OF_MASS_MODE_CUSTOM
	body.center_of_mass = Vector2(0, 20)
	body.angular_damp = 3.0
	rotation_angle = 0.0


func physics_process(delta: float) -> void:
	if (body.get_contact_count() == 0):
		transition_request.emit("AirborneState")
	
	if Input.is_action_pressed("ui_right"):
		rotation_angle = minf(rotation_angle + ROTATION_SPEED * delta, MAX_ANGLE)

	if Input.is_action_pressed("ui_left"):
		rotation_angle = maxf(rotation_angle - ROTATION_SPEED * delta, -MAX_ANGLE)
	
	jump_direction = -body.transform.y.rotated(deg_to_rad(rotation_angle))
	print(jump_direction)
	if Input.is_action_pressed("ui_accept"):
		charge_time = minf(charge_time + delta, max_charge_time)
		
	elif Input.is_action_just_released("ui_accept"):
		if body.get_contact_count() > 0:
			var t := charge_time / max_charge_time
			body.apply_central_impulse(jump_direction * lerpf(min_jump_impulse, max_jump_impulse, t))
			
		charge_time = 0.0
		
