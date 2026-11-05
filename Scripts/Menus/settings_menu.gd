extends Control

@export var music_slider: HSlider
@export var sfx_slider: HSlider
@export var back_button: Button

var music_bus := AudioServer.get_bus_index("Music")
var sfx_bus := AudioServer.get_bus_index("SFX")

func _ready() -> void:
	process_mode = Node.PROCESS_MODE_ALWAYS
	hide()

	music_slider.value = db_to_linear(
		AudioServer.get_bus_volume_db(music_bus)
	)
	sfx_slider.value = db_to_linear(
		AudioServer.get_bus_volume_db(sfx_bus)
	)

	music_slider.value_changed.connect(_on_music_changed)
	sfx_slider.value_changed.connect(_on_sfx_changed)
	back_button.pressed.connect(back_button_pressed)

func _on_music_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(
		music_bus,
		linear_to_db(value) if value > 0.0 else -80.0
	)

func _on_sfx_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(
		sfx_bus,
		linear_to_db(value) if value > 0.0 else -80.0
	)

func back_button_pressed() -> void:
	MenuManager.close_menu()
