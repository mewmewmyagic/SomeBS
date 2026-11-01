extends Node

@export var initial_state: State
var current_state: State


func _ready() -> void:
	for child in get_children():
		if child is State:
			child.body = get_parent()
			child.transition_request.connect(on_transition_requested)

	if initial_state:
		initial_state.enter()
		current_state = initial_state


func on_transition_requested(new_state_path: String) -> void:
	if current_state:
		current_state.exit()
		
	var new_state: State = get_node(new_state_path) as State
	if new_state and new_state is State:
		current_state = new_state
		current_state.enter()
	else:
		push_error("StateMachine: State '%s' not found or is not a State." % new_state_path)

func _unhandled_input(event: InputEvent) -> void:
	if current_state:
		current_state.on_input(event)


func _physics_process(delta: float) -> void:
	if current_state:
		current_state.physics_process(delta)
