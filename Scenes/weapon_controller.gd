extends Node2D
class_name WeaponController

@export var projectile: PackedScene
@export var fire_delay := 0.5  # seconds between shots
@export var body: PlatformerPlayer

var cooldown := 0.0

func _process(delta: float) -> void:
	cooldown -= delta
	if Input.is_action_pressed("Left Mouse") and cooldown <= 0.0:
		cooldown = fire_delay
		if projectile != null:
			_fire()

func _fire() -> void:
	var parent: Node = get_tree().current_scene
	var weapon: Weapon = projectile.instantiate() as Weapon
	
	parent.add_child(weapon)
	
	var offset := global_position - body.global_position
	weapon.global_position = body.global_position + Vector2(abs(offset.x) * body.facing_dir, offset.y)
	weapon.execute(Vector2(body.facing_dir, 0))
