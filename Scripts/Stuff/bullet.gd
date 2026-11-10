extends PhysicsBody2D
class_name Bullet

var velocity: Vector2
var active := false

func spawn(dir: Vector2, speed: float) -> void:
	velocity = dir * speed
	active = true
	visible = true
	process_mode = Node.PROCESS_MODE_INHERIT
	_set_collision_enabled.call_deferred(true)

func despawn() -> void:
	velocity = Vector2.ZERO
	active = false
	visible = false
	process_mode = Node.PROCESS_MODE_DISABLED
	_set_collision_enabled.call_deferred(false)

func _set_collision_enabled(enabled: bool) -> void:
	for child in get_children():
		if child is CollisionShape2D:
			child.disabled = not enabled

func _physics_process(delta: float) -> void:
	var collision := move_and_collide(velocity * delta)
	if collision != null:
		despawn()
