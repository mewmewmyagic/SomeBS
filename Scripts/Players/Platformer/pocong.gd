extends RigidBody2D

@export var min_jump_impulse: float = 200.0
@export var max_jump_impulse: float = 600.0
@export var max_charge_time: float = 1.0
@export var lean_torque: float = 3000.0

var charge_time := 0.0


func _ready() -> void:
	center_of_mass_mode = RigidBody2D.CENTER_OF_MASS_MODE_CUSTOM
	center_of_mass = Vector2(0, 20)  # low, near the feet (+y is down)
	angular_damp = 3.0               # stops it rocking forever
	contact_monitor = true
	max_contacts_reported = 1
