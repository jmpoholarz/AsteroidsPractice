extends Node

var scoreValueLabel

func _ready():
	scoreValueLabel = get_node("UI/LeftDock/scoreValueLabel")
	scoreValueLabel.text = str(0)

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass

func increase_score(amount):
	print("increase_score called with amount:" + str(amount))
	var score = int(scoreValueLabel.text)
	score += amount
	scoreValueLabel.text = str(score)