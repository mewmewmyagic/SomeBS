extends Control

@export var main_menu: Control
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	process_mode = Node.PROCESS_MODE_ALWAYS
	MusicManager.switch_music(MusicManager.title_screen_song)
	MenuManager.open_menu(main_menu)
