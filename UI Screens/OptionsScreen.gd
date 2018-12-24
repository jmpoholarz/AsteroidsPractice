extends Node

signal changeScreenTo

var inReassignMode = false
var actionReassigning = ""
var buttonReassigning

func _ready():
	# Connect signals
	connect("changeScreenTo", get_tree().get_root().get_node("Main"), "changeScreenTo")
	# Populate settings
	load_config()
	# Auto focus Volume Slider
	$VBoxContainer/VolumeContainer/VolumeSlider.grab_focus()
	set_process_input(true) #Needed?


##TODO::Handle Pause Button

## NOTE: Bug with reassigning spacebar will double call ui_accept
## Fixed in godot/master
func _input(event):
	# Ignore non key input events
	if not event is InputEventKey:
		return
	
	# Ignore input if not trying to reassign
	if inReassignMode == false:
		if event.is_action_pressed("ui_cancel"):
			if $HighScoreResetConfirmation.visible == false and $ScoresResetOK.visible == false:
				# Save config and return to title screen
				save_config()
				SoundManager.playSFX(SoundManager.DECLINE)
				emit_signal("changeScreenTo", "TITLE")
				queue_free()
		elif $HighScoreResetConfirmation.get_ok().has_focus():
			if event.is_action_pressed("ui_right"):
				SoundManager.playSFX(SoundManager.BLIP)
		elif $HighScoreResetConfirmation.get_cancel().has_focus() :
			if event.is_action_pressed("ui_left"):
				SoundManager.playSFX(SoundManager.BLIP)
		elif $ScoresResetOK.has_focus():
			pass
		elif event.is_action_pressed("ui_up") and !$VBoxContainer/VolumeContainer/VolumeSlider.has_focus():
			SoundManager.playSFX(SoundManager.BLIP)
		elif event.is_action_pressed("ui_down") and !$VBoxContainer/ResetScoresButton.has_focus():
			SoundManager.playSFX(SoundManager.BLIP)
		elif event.is_action_pressed("ui_right") and $VBoxContainer/VolumeContainer/VolumeSlider.has_focus():
			SoundManager.playSFX(SoundManager.BLIP)
		elif event.is_action_pressed("ui_left") and $VBoxContainer/VolumeContainer/VolumeSlider.has_focus():
			SoundManager.playSFX(SoundManager.BLIP)
		return
	# Handle reassigning
	var scancode = OS.get_scancode_string(event.scancode)
	buttonReassigning.text = scancode
	for oldEvent in InputMap.get_action_list(actionReassigning):
		InputMap.action_erase_event(actionReassigning, oldEvent)
	# Add the new key binding
	InputMap.action_add_event(actionReassigning, event)
	####save_to_config("input", actionReassigning, scancode)
	# End reassigning
	inReassignMode = false
	SoundManager.playSFX(SoundManager.ACCEPT)

func _on_VolumeSlider_value_changed(value):
	SettingsNode.volume = $VBoxContainer/VolumeContainer/VolumeSlider.value
	SoundManager.updateVolume()

func _on_ResetScoresButton_pressed():
	$HighScoreResetConfirmation.popup()
	SoundManager.playSFX(SoundManager.ACCEPT)

func _on_HighScoreResetConfirmation_confirmed():
	ScoreManager.resetScores()
	$ScoresResetOK.popup()
	SoundManager.playSFX(SoundManager.ACCEPT)

# doesn't seem to work?
func _on_HighScoreResetConfirmation_modal_closed():
	SoundManager.playSFX(SoundManager.DECLINE)
	
func _on_ScoresResetOK_confirmed():
	SoundManager.playSFX(SoundManager.ACCEPT)

func _on_ScoresResetOK_modal_closed():
	SoundManager.playSFX(SoundManager.DECLINE)


# Handle all of the Control button remaps
func _on_ForwardButton_pressed():
	inReassignMode = true
	buttonReassigning = $VBoxContainer/GridContainer/ForwardButton
	actionReassigning = "ship_go_forward"
func _on_BackButton_pressed():
	inReassignMode = true
	buttonReassigning = $VBoxContainer/GridContainer/BackButton
	actionReassigning = "ship_go_backward"
func _on_TurnCCWButton_pressed():
	inReassignMode = true
	buttonReassigning = $VBoxContainer/GridContainer/TurnCCWButton
	actionReassigning = "ship_rotate_left"
func _on_TurnCWButton_pressed():
	inReassignMode = true
	buttonReassigning = $VBoxContainer/GridContainer/TurnCWButton
	actionReassigning = "ship_rotate_right"
func _on_ShootButton_pressed():
	inReassignMode = true
	buttonReassigning = $VBoxContainer/GridContainer/ShootButton
	actionReassigning = "ship_shoot"
func _on_PauseButton_pressed():
	inReassignMode = true
	buttonReassigning = $VBoxContainer/GridContainer/PauseButton
	actionReassigning = "ui_pause"


func load_config():
	SettingsNode.load_config()
	# Read settings
	# Volume
	$VBoxContainer/VolumeContainer/VolumeSlider.value = SettingsNode.volume
	SoundManager.updateVolume()
	# Controls
	$VBoxContainer/GridContainer/ForwardButton.text = OS.get_scancode_string(InputMap.get_action_list("ship_go_forward")[0].scancode)
	$VBoxContainer/GridContainer/BackButton.text = OS.get_scancode_string(InputMap.get_action_list("ship_go_backward")[0].scancode)
	$VBoxContainer/GridContainer/TurnCCWButton.text = OS.get_scancode_string(InputMap.get_action_list("ship_rotate_left")[0].scancode)
	$VBoxContainer/GridContainer/TurnCWButton.text = OS.get_scancode_string(InputMap.get_action_list("ship_rotate_right")[0].scancode)
	$VBoxContainer/GridContainer/ShootButton.text = OS.get_scancode_string(InputMap.get_action_list("ship_shoot")[0].scancode)
	$VBoxContainer/GridContainer/PauseButton.text = OS.get_scancode_string(InputMap.get_action_list("ui_pause")[0].scancode)


func save_config():
	# Open the config
	var config = ConfigFile.new()
	# Handle audio settings
	config.set_value("audio", "volume", $VBoxContainer/VolumeContainer/VolumeSlider.value)
	SettingsNode.volume = $VBoxContainer/VolumeContainer/VolumeSlider.value
	# Handle keybind settings
	var x = InputMap.get_action_list("ship_go_forward").front().scancode
	config.set_value("keybinds", "ship_go_forward", x)
	x = InputMap.get_action_list("ship_go_backward").front().scancode
	config.set_value("keybinds", "ship_go_backward", x)
	x = InputMap.get_action_list("ship_rotate_left").front().scancode
	config.set_value("keybinds", "ship_rotate_left", x)
	x = InputMap.get_action_list("ship_rotate_right").front().scancode
	config.set_value("keybinds", "ship_rotate_right", x)
	x = InputMap.get_action_list("ship_shoot").front().scancode
	config.set_value("keybinds", "ship_shoot", x)
	x = InputMap.get_action_list("ui_pause").front().scancode
	config.set_value("keybinds", "ui_pause", x)
	# Save file
	config.save("user://settings.cfg")
	
	# Tell SoundManager to update setting
	SoundManager.updateVolume()






