extends State
class_name PlayerState

@export var body: RigidBody2D

func _ready() -> void:
	await owner.ready
	body = owner as RigidBody2D
