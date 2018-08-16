extends Node

var screenHolder # Node managing the screens

func _ready():
	# Start Title Screen
	changeScreenTo("TITLE")
	pass


func changeScreenTo(screen):
	match screen:
		"TITLE":
			var titleScreen = load("res://UI Screens/TitleScreen.tscn")
			$Screen.add_child(titleScreen.instance())
		"PLAY":
			var playScreen = load("res://Play.tscn")
			$Screen.add_child(playScreen.instance())
		"OPTIONS":
			var optionsScreen = load("res://UI Screens/OptionsScreen.tscn")
			$Screen.add_child(optionsScreen.instance())