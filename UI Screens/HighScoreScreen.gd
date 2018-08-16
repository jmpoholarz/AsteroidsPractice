extends Node

var sampleData = [["ZZZ", 15000], ["YYY", 14000], ["XXX", 13000], ["WWW",11500],
	["VVV",10000], ["UUU", 8000], ["TTT", 6400], ["SSS", 4200]]

func _ready():
	populateScores(sampleData)


func populateScores(data):
	for row in range(data.size()):
		# Get names of nodes
		var nameNode = "Name" + str(row)
		var scoreNode = "Score" + str(row)
		# Get values to insert
		var name = data[row][0]
		var score = data[row][1]
		# Assign to actual nodes
		var nameNodePath = "VBoxContainer/Grid/" + nameNode
		var scoreNodePath = "VBoxContainer/Grid/" + scoreNode
		get_node(nameNodePath).text = name
		get_node(scoreNodePath).text = str(score)
