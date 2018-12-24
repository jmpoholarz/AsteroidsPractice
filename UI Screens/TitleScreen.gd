extends Node

signal changeScreenTo

var isCurrentScreen = false

func _ready():
	# Init signals
	connect("changeScreenTo", get_tree().get_root().get_node("Main"), "changeScreenTo")
	# Auto-select Start Button
	$VBoxContainer/StartButton.grab_focus()
	pass

func _input(event):
	if event.is_action_pressed("ui_up"):
		SoundManager.playSFX(SoundManager.BLIP)
	elif event.is_action_pressed("ui_down"):
		SoundManager.playSFX(SoundManager.BLIP)


func _on_StartButton_pressed():
	# Change to Play Screen 
	SoundManager.playSFX(SoundManager.ACCEPT)
	emit_signal("changeScreenTo", "PLAY")
	# Remove Title Screen
	queue_free()


func _on_OptionsButton_pressed():
	# Change to Options Screen
	SoundManager.playSFX(SoundManager.ACCEPT)
	emit_signal("changeScreenTo", "OPTIONS")
	# Remove Title Screen
	queue_free()


func _on_QuitButton_pressed():
	# Exit Game
	get_tree().quit()
