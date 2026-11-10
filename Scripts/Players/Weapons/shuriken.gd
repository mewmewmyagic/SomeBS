extends Weapon

@export var speed: float =  800
var velocity: Vector2
func execute(dir: Vector2) -> void:
	velocity = speed * dir
	print(velocity)
	
func _physics_process(delta: float) -> void:
	var collision := move_and_collide(velocity * delta)
	if collision != null:
		pass
