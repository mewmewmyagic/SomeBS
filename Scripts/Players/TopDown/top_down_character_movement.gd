extends CharacterBody2D
class_name TopDownPlayer

@export var walk_speed: float = 150
@export var run_speed: float = 300
@export var accel: float = 600
@export var deaccel: float = 600

@export var footsteps_player: AudioStreamPlayer

func _physics_process(delta: float) -> void:
	for i in get_slide_collision_count():
		var collision = get_slide_collision(i)
		var body = collision.get_collider()

		if body is RigidBody2D:
			var normal = collision.get_normal()
			
			var relative_velocity = velocity - body.linear_velocity
			var impact_speed = relative_velocity.dot(-normal)
			
			if impact_speed > 0.0:
				var impulse = impact_speed * body.mass
				body.apply_central_impulse(-normal * impulse)
				
				
func play_footsteps(from: float, to: float) -> void:
	if not footsteps_player.playing:
		footsteps_player.pitch_scale = randf_range(from, to)
		footsteps_player.play()
