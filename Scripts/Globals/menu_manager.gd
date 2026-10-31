extends Node

var stack: Array[Control] = []

#TODO dont pause in this script
func _ready() -> void:
	process_mode = Node.PROCESS_MODE_ALWAYS

func open_menu(menu: Control) -> void:
	if not stack.is_empty():
		stack.back().hide()
	else:
		get_tree().paused = true
	stack.push_back(menu)
	menu.show()

func close_menu() -> void:
	if stack.is_empty():
		return
	stack.pop_back().hide()
	if stack.is_empty():
		get_tree().paused = false
	else:
		stack.back().show()

func close_all() -> void:
	while not stack.is_empty():
		close_menu()

func toggle(menu: Control) -> void:
	if stack.is_empty():
		open_menu(menu)
	else:
		close_menu()
