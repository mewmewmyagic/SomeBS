extends Node

var music_player: AudioStreamPlayer
const audio_bus = "Music"

@export var title_screen_song: AudioStream
@export var gameplay_song: AudioStream

func _ready() -> void:
	process_mode = Node.PROCESS_MODE_ALWAYS
	
	title_screen_song = preload("res://SomeBS/Noise/Music/Certainly1.mp3")
	gameplay_song = preload("res://SomeBS/Noise/Music/Pizza-Pizza-3.mp3")
	
	music_player = AudioStreamPlayer.new()
	music_player.bus = audio_bus
	add_child(music_player)


func switch_music(new_song: AudioStream, fade_duration: float = 0.0) -> void:
	if music_player.stream == new_song:
		return
	if fade_duration > 0.0:
		await fade_out(fade_duration)

	music_player.stream = new_song
	music_player.play()

	if fade_duration > 0.0:
		await fade_in(fade_duration)


func stop_music(fade_duration: float = 0.0) -> void:
	if fade_duration > 0.0:
		await fade_out(fade_duration)

	music_player.stop()


func fade_out(duration: float) -> void:
	var tween := create_tween()
	tween.tween_property(music_player, "volume_db", -40.0, duration)
	await tween.finished


func fade_in(duration: float) -> void:
	music_player.volume_db = -40.0

	var tween := create_tween()
	tween.tween_property(music_player, "volume_db", 0.0, duration)
	await tween.finished
