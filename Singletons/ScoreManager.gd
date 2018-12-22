extends Node

var scoreArray
var maxScoreCount = 8

func _ready():
	scoreArray = []
	load_scores()

func getTopScore():
	return scoreArray[0][0]

func insertScore(score, name):
	for i in range(scoreArray.size()):
		# Check if beats this score
		if scoreArray[i][0] < score:
			# Insert above this score
			scoreArray.insert(i, [score, name])
			# If array maxed out, remove last value
			if scoreArray.size() > maxScoreCount:
				scoreArray.pop_back()
			save_scores()
			return i
	# Add to end of array if array not full
	if scoreArray.size() < maxScoreCount:
		scoreArray.push_back([score, name])
		save_scores()
		return scoreArray.size() - 1
	return -1


func isNewHighScore(score):
	for i in range(scoreArray.size()):
		if score > scoreArray[i][0]:
			return true
	return false


func printScores():
	for i in range(scoreArray.size()):
		print(str(scoreArray[i][0]) + " " + scoreArray[i][1])


func createDefaultScores():
	var config = ConfigFile.new()
	# Save scores
	config.set_value("scores", "0", [10000, "AAA"])
	config.set_value("scores", "1", [8000, "BBB"])
	config.set_value("scores", "2", [6000, "CCC"])
	config.set_value("scores", "3", [4000, "DDD"])
	config.set_value("scores", "4", [3000, "EEE"])
	config.set_value("scores", "5", [2000, "FFF"])
	config.set_value("scores", "6", [1000, "GGG"])
	config.set_value("scores", "7", [100, "HHH"])
	# Create the new config file
	config.save("user://highscores.cfg")


func save_scores():
	var config = ConfigFile.new()
	# Save scores
	config.set_value("scores", "0", scoreArray[0])
	config.set_value("scores", "1", scoreArray[1])
	config.set_value("scores", "2", scoreArray[2])
	config.set_value("scores", "3", scoreArray[3])
	config.set_value("scores", "4", scoreArray[4])
	config.set_value("scores", "5", scoreArray[5])
	config.set_value("scores", "6", scoreArray[6])
	config.set_value("scores", "7", scoreArray[7])
	# Create the new config file
	config.save("user://highscores.cfg")


func load_scores():
	scoreArray = []
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


func resetScores():
	createDefaultScores()
	load_scores()
