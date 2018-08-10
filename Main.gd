extends Node

var scoreValueLabel
var highScoreValueLabel
var lifeValueLabel
var levelValueLabel

func _ready():
	# Reference nodes
	scoreValueLabel = get_node("UI/LeftDock/scoreValueLabel")
	highScoreValueLabel = get_node("UI/RightDock/highValueLabel")
	lifeValueLabel = get_node("UI/CenterDock/lifeLevelContainer/lifeValueLabel")
	levelValueLabel = get_node("UI/CenterDock/lifeLevelContainer/levelLabel")
	# Set values
	scoreValueLabel.text = str(0)
	highScoreValueLabel.text = str(25000)
	lifeValueLabel.text = "x3"
	levelValueLabel.text = str(1)

func _process(delta):
	if get_tree().get_nodes_in_group("asteroids").size() == 0:
		increase_level()

func increase_score(amount):
	var score = int(scoreValueLabel.text)
	score += amount
	scoreValueLabel.text = str(score)

func set_lives_relative(amount):
	var lives = int(lifeValueLabel.text.erase(0,1))
	lives += amount
	lifeValueLabel.text = "x" + str(lives)
	
func increase_level():
	var level = int(levelValueLabel.text)
	level += 1
	levelValueLabel.text = str(level)
