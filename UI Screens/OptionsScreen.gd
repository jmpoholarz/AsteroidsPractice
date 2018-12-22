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
		if event.is_action("ui_cancel"):
			# Save config and return to title screen
			save_config()
			emit_signal("changeScreenTo", "TITLE")
			queue_free()
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


func _on_ResetScoresButton_pressed():
	$HighScoreResetConfirmation.popup()

func _on_HighScoreResetConfirmation_confirmed():
	ScoreManager.resetScores()
	$ScoresResetOK.popup()

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



func create_default_config():
	var config = ConfigFile.new()
	# Handle Audio settings
	config.set_value("audio", "volume", 100)
	# Handle Keybind settings
	config.set_value("keybinds", "ship_go_forward", KEY_UP)
	config.set_value("keybinds", "ship_go_backward", KEY_DOWN)
	config.set_value("keybinds", "ship_rotate_left", KEY_LEFT)
	config.set_value("keybinds", "ship_rotate_right", KEY_RIGHT)
	config.set_value("keybinds", "ship_shoot", KEY_Z)
	config.set_value("keybinds", "ui_pause", KEY_P)
	# Create the new config file
	config.save("user://settings.cfg")

func load_config():
	# Open the config
	var config = ConfigFile.new()
	var error = config.load("user://settings.cfg")
	if error != OK:
		print("Creating settings file...")
		create_default_config()
		load_config()
		return
	# Read settings
	# Volume
	if config.has_section_key("audio", "volume"):
		SettingsNode.volume = config.get_value("audio", "volume")
		$VBoxContainer/VolumeContainer/VolumeSlider.value = SettingsNode.volume
	# Controls
	if config.has_section_key("keybinds", "ship_go_forward"):
		# Erase old keybind
		for oldEvent in InputMap.get_action_list("ship_go_forward"):
			InputMap.action_erase_event("ship_go_forward", oldEvent)
		# Apply new keybind
		var event = InputEventKey.new()
		event.scancode = config.get_value("keybinds", "ship_go_forward")
		InputMap.action_add_event("ship_go_forward", event)
		# Update UI
		$VBoxContainer/GridContainer/ForwardButton.text = OS.get_scancode_string(event.scancode)
	if config.has_section_key("keybinds", "ship_go_backward"):
		# Erase old keybind
		for oldEvent in InputMap.get_action_list("ship_go_backward"):
			InputMap.action_erase_event("ship_go_backward", oldEvent)
		# Apply new keybind
		var event = InputEventKey.new()
		event.scancode = config.get_value("keybinds", "ship_go_backward")
		InputMap.action_add_event("ship_go_backward", event)
		# Update UI
		$VBoxContainer/GridContainer/BackButton.text = OS.get_scancode_string(event.scancode)
	if config.has_section_key("keybinds", "ship_rotate_left"):
		# Erase old keybind
		for oldEvent in InputMap.get_action_list("ship_rotate_left"):
			InputMap.action_erase_event("ship_rotate_left", oldEvent)
		# Apply new keybind
		var event = InputEventKey.new()
		event.scancode = config.get_value("keybinds", "ship_rotate_left")
		InputMap.action_add_event("ship_rotate_left", event)
		# Update UI
		$VBoxContainer/GridContainer/TurnCCWButton.text = OS.get_scancode_string(event.scancode)
	if config.has_section_key("keybinds", "ship_rotate_right"):
		# Erase old keybind
		for oldEvent in InputMap.get_action_list("ship_rotate_right"):
			InputMap.action_erase_event("ship_rotate_right", oldEvent)
		# Apply new keybind
		var event = InputEventKey.new()
		event.scancode = config.get_value("keybinds", "ship_rotate_right")
		InputMap.action_add_event("ship_rotate_right", event)
		# Update UI
		$VBoxContainer/GridContainer/TurnCWButton.text = OS.get_scancode_string(event.scancode)
	if config.has_section_key("keybinds", "ship_shoot"):
		# Erase old keybind
		for oldEvent in InputMap.get_action_list("ship_shoot"):
			InputMap.action_erase_event("ship_shoot", oldEvent)
		# Apply new keybind
		var event = InputEventKey.new()
		event.scancode = config.get_value("keybinds", "ship_shoot")
		InputMap.action_add_event("ship_shoot", event)
		# Update UI
		$VBoxContainer/GridContainer/ShootButton.text = OS.get_scancode_string(event.scancode)
	if config.has_section_key("keybinds", "ui_pause"):
		# Erase old keybind
		for oldEvent in InputMap.get_action_list("ui_pause"):
			InputMap.action_erase_event("ui_pause", oldEvent)
		# Apply new keybind
		var event = InputEventKey.new()
		event.scancode = config.get_value("keybinds", "ui_pause")
		InputMap.action_add_event("ui_pause", event)
		# Update UI
		$VBoxContainer/GridContainer/PauseButton.text = OS.get_scancode_string(event.scancode)


func save_config():
	# Open the config
	var config = ConfigFile.new()
	# Handle audio settings
	config.set_value("audio", "volume", $VBoxContainer/VolumeContainer/VolumeSlider.value)
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
