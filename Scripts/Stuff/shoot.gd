extends Node2D

@export var projectile: PackedScene
@export var speed := 100.0
@export var pool_size: int = 50
@export var fire_delay := 0.1  # seconds between shots
@export var gun_shot_sound: AudioStreamPlayer

var pool: Array[Bullet]
var cooldown := 0.0

func _ready() -> void:
	var parent: Node = get_tree().current_scene
	for i in range(pool_size):
		var bullet: Bullet = projectile.instantiate() as Bullet
		parent.add_child.call_deferred(bullet)
		bullet.despawn.call_deferred()
		pool.push_back(bullet)

func _process(delta: float) -> void:
	cooldown -= delta
	if Input.is_action_pressed("Left Mouse") and cooldown <= 0.0:
		cooldown = fire_delay
		_fire()

func _fire() -> void:
	var bullet: Bullet = null
	for p in pool:
		if not p.active:
			bullet = p
			break
	
	if bullet == null:
		bullet = pool.pop_front()
		pool.push_back(bullet)
	
	bullet.global_position = global_position
	bullet.spawn(Vector2.RIGHT.rotated(global_rotation), speed)
	gun_shot_sound.pitch_scale = randf_range(1.9, 2.1)
	gun_shot_sound.play()
