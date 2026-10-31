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
	while true:
		await get_tree().physics_frame
		
		#waits for input
		var dir := _read_input()
		if dir == Vector2.ZERO:
			continue

		var ray := _get_ray_cast(dir)
		ray.force_raycast_update()

		# Free tile: walk
		if not ray.is_colliding():
			move(dir)
			await tween.finished
			return

func _read_input() -> Vector2:
	if Input.is_action_pressed("ui_up"):
		return Vector2.UP
	if Input.is_action_pressed("ui_down"):
		return Vector2.DOWN
	if Input.is_action_pressed("ui_left"):
		return Vector2.LEFT
	if Input.is_action_pressed("ui_right"):
		return Vector2.RIGHT
	return Vector2.ZERO
	
func _get_ray_cast(dir: Vector2) -> RayCast2D:
	match dir:
		Vector2.UP:
			return up
		Vector2.DOWN:
			return down
		Vector2.LEFT:
			return left
		_:
			return right
			
func move(dir: Vector2) -> void:
	#is the ray cast in same direction as dir colliding with something?
	# if its colliding with something in group moveable, move that thing in dir
	#else return
	print(dir*tile_size)
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
