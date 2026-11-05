extends Node

@export var sounds: Dictionary[String, AudioStream] = {}  # Godot 4.4+; use plain `Dictionary` on older versions
@export var pool_size := 8

const audio_bus = "SFX"
var players: Array[AudioStreamPlayer] = []

func _ready() -> void:
	for i in pool_size:
		var p := AudioStreamPlayer.new()
		p.bus = audio_bus
		add_child(p)
		players.append(p)
			
func play(name: String):
	if not sounds.has(name):
		push_error("sound effect '%s' doesnt exist", % name)
		return
	for p in players:
		if not p.playing:
			p.stream = sounds[name]
			p.pitch_scale = randf_range(0.9, 1.1)
			p.play()
