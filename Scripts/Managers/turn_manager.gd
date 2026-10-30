extends Node

@export var max_turns: int
@export var actors: Array[Node]

func _ready() -> void:
	an_entire_level()

func turn_flow() -> void:
	for actor in actors:
		await actor.execute()

func an_entire_level() -> void:
	for i in range(max_turns):
		print(i)
		await turn_flow()
	print("poop")
