extends CanvasLayer
class_name UI

@onready var score_labbel = %Label

var score = 0
var max_score = 30

func update_score(value):
	score += value
	update_score_label()
	
func update_score_label():
	score_labbel.text = "Score: " + str(score)
