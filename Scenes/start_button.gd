extends Button

@export_file("*.tscn") var next_scene: String

func start_game() -> void:
	SceneLoader.load_scene(next_scene)


func _on_button_down() -> void:
	start_game()
	
func quit() -> void:
	get_tree().quit()
