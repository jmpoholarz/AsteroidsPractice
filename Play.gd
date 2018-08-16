extends Node

signal changeScreenTo

var scoreValueLabel
var highScoreValueLabel
var lifeValueLabel
var levelValueLabel
var levelManager

func _ready():
	# Reference nodes
	scoreValueLabel = get_node("UI/LeftDock/scoreValueLabel")
	highScoreValueLabel = get_node("UI/RightDock/highValueLabel")
	lifeValueLabel = get_node("UI/CenterDock/lifeLevelContainer/lifeValueLabel")
	levelValueLabel = get_node("UI/CenterDock/lifeLevelContainer/levelLabel")
	levelManager = get_node("UI/CenterDock/ViewportContainer/Viewport/LevelManager")
	# Connect signals
	connect("changeScreenTo", get_node("/root/Main"), "changeScreenTo")
	# Set values
	scoreValueLabel.text = str(0)
	highScoreValueLabel.text = str(25000)
	lifeValueLabel.text = "x3"
	levelValueLabel.text = str(1)
	$PauseWindow.visible = false

func _process(delta):
	# Check if paused button pressed
	if Input.is_action_just_pressed('ui_pause'):
		$PauseWindow.show()
		get_tree().paused = true
	
	if get_tree().get_nodes_in_group("asteroids").size() == 0:
		increase_level()

func increase_score(amount):
	var score = int(scoreValueLabel.text)
	score += amount
	scoreValueLabel.text = str(score)

func set_lives_relative(amount):
	# Remove 'x' from label
	lifeValueLabel.text.erase(0,1)
	# Change by amount
	var lives = int(lifeValueLabel.text)
	lives += amount
	# Readd the 'x' and set label
	lifeValueLabel.text = "x" + str(lives)
	# End game if out of lives
	if lives <= 0:
		game_over()
	
func increase_level():
	# Update GUI
	var level = int(levelValueLabel.text)
	level += 1
	levelValueLabel.text = str(level)
	# Advance level in levelManager
	levelManager.load_level(level)


func game_over():
	# Display game over message and change screen
	##TODO High Score & Game Over
	emit_signal("changeScreenTo", "TITLE")
	queue_free()