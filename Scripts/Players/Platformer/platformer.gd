extends CharacterBody2D
class_name PlatformerPlayer

@export var walk_speed: float = 150
@export var run_speed: float = 300
@export var accel: float = 1200
@export var deaccel: float = 1200
@export var jump_velocity: float = 400
@export var coyote_time: float = 0.05
@export var double_jumps: int = 1
@export var sprite: Sprite2D
var jumps: int = 0

@export var jump_buffer_time: float = 0.05

var input_dir: Vector2 = Vector2.ZERO
var jump_requested: bool = false
var run_held: bool = false

var jump_buffer_timer: float = 0.0
var facing_dir: int = 1

func _process(delta: float) -> void:
	input_dir.x = Input.get_axis("Left", "Right")
	input_dir.y = Input.get_axis("Up", "Down")
	
	if input_dir.x != 0:
		facing_dir = sign(input_dir.x)
	
	sprite.flip_v = (facing_dir < 0)
	
	run_held = Input.is_action_pressed("Shift")

	if Input.is_action_just_pressed("Space"):
		jump_requested = true
		jump_buffer_timer = jump_buffer_time

	if jump_requested:
		jump_buffer_timer -= delta

		if jump_buffer_timer <= 0.0:
			jump_requested = false

func consume_jump() -> bool:
	if jump_requested:
		jump_requested = false
		return true

	return false
