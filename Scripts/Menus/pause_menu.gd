extends Control

@export var resume_button: Button
@export var settings_button: Button
@export var main_menu_button: Button

@export var settings_menu: Control

@export_file("*.tscn") var main_menu: String

func _ready() -> void:
	process_mode = Node.PROCESS_MODE_ALWAYS
	hide()

	resume_button.pressed.connect(resume_pressed)
	main_menu_button.pressed.connect(main_menu_pressed)
	settings_button.pressed.connect(settings_pressed)

func resume_pressed() -> void:
	MenuManager.close_all()

func main_menu_pressed() -> void:
	MenuManager.close_all()
	SceneLoader.load_scene(main_menu)

func settings_pressed() -> void:
	MenuManager.open_menu(settings_menu)
