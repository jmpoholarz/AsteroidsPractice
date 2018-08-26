extends Node

var scoreArray
var maxScoreCount = 10

func _ready():
	scoreArray = []
	load_scores()

func insertScore(score, name):
	for i in range(scoreArray.size()):
		# Check if beats this score
		if scoreArray[i][0] < score:
			# Insert above this score
			scoreArray.insert(i, [score, name])
			# If array maxed out, remove last value
			if scoreArray.size() > maxScoreCount:
				scoreArray.pop_back()
			return i
	# Add to end of array if array not full
	if scoreArray.size() < maxScoreCount:
		scoreArray.push_back([score, name])
		return scoreArray.size() - 1
	return -1


func isNewHighScore(score):
	for i in range(scoreArray.size()):
		if score > scoreArray[i]:
			return true
	return false


func printScores():
	for i in range(scoreArray.size()):
		print(str(scoreArray[i][0]) + " " + scoreArray[i][1])


func createDefaultScores():
	var config = ConfigFile.new()
	# Save scores
	config.set_value("scores", "0", 10000)
	config.set_value("scores", "1", 9000)
	config.set_value("scores", "2", 8000)
	config.set_value("scores", "3", 7000)
	config.set_value("scores", "4", 6000)
	config.set_value("scores", "5", 5000)
	config.set_value("scores", "6", 4000)
	config.set_value("scores", "7", 3000)
	config.set_value("scores", "8", 2000)
	config.set_value("scores", "9", 1000)
	# Create the new config file
	config.save("user://highscores.cfg")



func load_scores():
	# Open the config
	var config = ConfigFile.new()
	var error = config.load("user://highscores.cfg")
	if error != OK:
		print("Creating highscores file...")
		createDefaultScores()
		load_scores()
		return
	# Read scores
	#if config.has_section_key("scores", "0"):
		#var x = config.get_value("scores", "0")
		#print(x)