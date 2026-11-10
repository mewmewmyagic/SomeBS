extends PlatformerState

const COYOTE_TIME := 0.1
const WALL_STICK_SPEED := 50.0

var coyote_timer := 0.0
var wall_dir := 0.0  # direction pointing INTO the wall

func enter() -> void:
	print(name)
	wall_dir = -body.get_wall_normal().x
	coyote_timer = COYOTE_TIME

func process(delta: float) -> void:
	if Input.is_action_just_pressed("Space"):
		body.velocity.x = -wall_dir * body.jump_velocity / 2
		transition_request.emit("JumpingState")

func physics_process(delta: float) -> void:
	body.velocity.x = wall_dir * WALL_STICK_SPEED  # keeps the collision alive
	body.velocity.y = body.input_dir.y * body.walk_speed
	body.move_and_slide()

	if body.is_on_wall():
		coyote_timer = COYOTE_TIME
	else:
		coyote_timer -= delta
		if coyote_timer <= 0.0:
			transition_request.emit("FallingState")
