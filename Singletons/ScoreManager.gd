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
	config.set_value("scores", "0", [10000, "AAA"])
	config.set_value("scores", "1", [9000, "BBB"])
	config.set_value("scores", "2", [8000, "CCC"])
	config.set_value("scores", "3", [7000, "DDD"])
	config.set_value("scores", "4", [6000, "EEE"])
	config.set_value("scores", "5", [5000, "FFF"])
	config.set_value("scores", "6", [4000, "GGG"])
	config.set_value("scores", "7", [3000, "HHH"])
	config.set_value("scores", "8", [2000, "III"])
	config.set_value("scores", "9", [1000, "JJJ"])
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
	for section in config.get_sections():
		for key in config.get_section_keys(section):
			scoreArray.push_back(config.get_value(section, key))
