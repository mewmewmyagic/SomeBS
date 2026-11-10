extends RichTextLabel

var score: int = 0
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	EventBus.add_score.connect(update_score)
	text = str(score)


func update_score() -> void:
	score += 1
	text = str(score)
