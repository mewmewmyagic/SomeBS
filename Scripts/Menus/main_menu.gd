extends Control

@export var start_button: Button
@export var settings_button: Button
@export var quit_button: Button

@export var settings_menu: Control

@export_file("*.tscn") var next_scene: String

func _ready() -> void:
	start_button.pressed.connect(start)
	settings_button.pressed.connect(settings)
	quit_button.pressed.connect(quit)

func start() -> void:
	MenuManager.close_all()
	SceneLoader.load_scene(next_scene)

func settings() -> void:
	MenuManager.open_menu(settings_menu)
	
func quit() -> void:
	get_tree().quit()
