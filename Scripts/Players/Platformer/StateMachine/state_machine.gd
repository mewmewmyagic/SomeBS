class_name StateMachine
extends Node

@export var initial_state: State
@export var character_body: TopDownPlayer

var current_state: State
var states: Dictionary = {} # StringName -> State


func _ready() -> void:
	for child in get_children():
		if child is State:
			states[child.name] = child
			child.body = character_body
			child.transition_request.connect(_on_transition_requested)

	if initial_state:
		current_state = initial_state
		current_state.enter()


func _on_transition_requested(state_name: StringName) -> void:
	var new_state: State = states.get(state_name)
	if new_state == null:
		push_error("StateMachine: State '%s' not found." % state_name)
		return
	if new_state == current_state:
		return

	if current_state:
		current_state.exit()
	current_state = new_state
	current_state.enter()


func _unhandled_input(event: InputEvent) -> void:
	if current_state:
		current_state.on_input(event)

func _process(delta: float) -> void:
	if current_state:
		current_state.process(delta)

func _physics_process(delta: float) -> void:
	if current_state:
		current_state.physics_process(delta)
