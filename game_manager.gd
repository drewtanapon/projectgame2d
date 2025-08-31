extends Node

var score = 0
var maxScore = 10
@onready var scorelabel = $"../player/Camera2D/ScoreLabel"

func add_point():
	score+=1
	scorelabel.text = "You collected " + str(score) + "/"+str(maxScore)+" coins."
