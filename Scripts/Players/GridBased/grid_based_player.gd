extends CharacterBody2D


const tile_size = Vector2(16,16)
const TWEEN_DURATION = 0.25

var tween: Tween
@export var up: RayCast2D
@export var down: RayCast2D
@export var left: RayCast2D
@export var right: RayCast2D
@export var sprite_2d: Sprite2D

func execute() -> void:
	var dir := Vector2.ZERO
	while dir == Vector2.ZERO:
		await get_tree().physics_frame
		dir = _read_input()
	move(dir)
	await tween.finished

func _read_input() -> Vector2:
	for r in [up, down, left, right]:
		r.force_raycast_update()
	if Input.is_action_pressed("ui_up") and not up.is_colliding():
		return Vector2.UP
	if Input.is_action_pressed("ui_down") and not down.is_colliding():
		return Vector2.DOWN
	if Input.is_action_pressed("ui_left") and not left.is_colliding():
		return Vector2.LEFT
	if Input.is_action_pressed("ui_right") and not right.is_colliding():
		return Vector2.RIGHT
	return Vector2.ZERO
		
func move(dir: Vector2) -> void:
	global_position += dir * tile_size
	sprite_2d.position -= dir * tile_size
	
	animate_sprite_movement()

func animate_sprite_movement() -> void:
	if tween and tween.is_running():
		tween.kill()

	tween = create_tween()
	tween.set_process_mode(Tween.TWEEN_PROCESS_PHYSICS)
	tween.set_trans(Tween.TRANS_QUAD)
	tween.set_ease(Tween.EASE_OUT)

	tween.tween_property(
		sprite_2d,
		"position",
		Vector2(0,0),
		TWEEN_DURATION
	)
