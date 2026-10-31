extends CharacterBody2D

@export var max_speed := 200.0

#kalau mau tidak akselerasi, acc dan fric kasih jauh lebih besar dari max speed
@export var acceleration := 320.0
@export var friction := 320.0
@export var sprite: Sprite2D

@export var rotation_acceleration := 20.0
@export var rotation_friction := 8.0

var angular_velocity := 0.0
var v := Vector2.RIGHT

func _physics_process(delta: float) -> void:
	var dir := _read_input()

	if dir != Vector2.ZERO:
		velocity += dir * acceleration * delta
	else:
		velocity = velocity.move_toward(Vector2.ZERO, friction * delta)

	velocity = velocity.limit_length(max_speed)
	move_and_slide()


func _read_input() -> Vector2:
	var dir := Vector2.ZERO

	if Input.is_action_pressed("Up"):
		dir.y = -1
	if Input.is_action_pressed("Down"):
		dir.y = 1
	if Input.is_action_pressed("Left"):
		dir.x = -1
	if Input.is_action_pressed("Right"):
		dir.x = 1

	return dir.normalized()
