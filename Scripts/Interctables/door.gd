extends Node

var is_in_range = false
@export var cooldown: Timer
@export var door_hitbox: StaticBody2D
@export var door_opened: bool = false
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	door_hitbox.get_node("CollisionShape2D").set_deferred("disabled", door_opened)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_mouse_button_pressed(MOUSE_BUTTON_RIGHT) and is_in_range and cooldown.is_stopped():
		door_opened = not door_opened
		door_hitbox.get_node("CollisionShape2D").set_deferred("disabled", door_opened)
		cooldown.start()

func _on_interact_area_body_entered(_body: Node2D) -> void:
	if _body.is_in_group("player"):
		is_in_range = true


func _on_interact_area_body_exited(_body: Node2D) -> void:
	if _body.is_in_group("player"):
		is_in_range = false
