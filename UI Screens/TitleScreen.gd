extends Node

signal changeScreenTo

var isCurrentScreen = false

func _ready():
	# Init signals
	connect("changeScreenTo", get_tree().get_root().get_node("Main"), "changeScreenTo")
	# Auto-select Start Button
	$VBoxContainer/StartButton.grab_focus()
	pass


func _on_StartButton_pressed():
	# Change to Play Screen
	emit_signal("changeScreenTo", "PLAY")
	# Remove Title Screen
	queue_free()


func _on_OptionsButton_pressed():
	# Change to Options Screen
	emit_signal("changeScreenTo", "OPTIONS")
	# Remove Title Screen
	queue_free()


func _on_QuitButton_pressed():
	# Exit Game
	get_tree().quit()
