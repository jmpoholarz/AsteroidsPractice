extends Node

var volume = 0

func _ready():
	pass


func create_default_config():
	var config = ConfigFile.new()
	# Handle Audio settings
	config.set_value("audio", "volume", 50)
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
		SoundManager.updateVolume()
	# Controls
	if config.has_section_key("keybinds", "ship_go_forward"):
		# Erase old keybind
		for oldEvent in InputMap.get_action_list("ship_go_forward"):
			InputMap.action_erase_event("ship_go_forward", oldEvent)
		# Apply new keybind
		var event = InputEventKey.new()
		event.scancode = config.get_value("keybinds", "ship_go_forward")
		InputMap.action_add_event("ship_go_forward", event)
	if config.has_section_key("keybinds", "ship_go_backward"):
		# Erase old keybind
		for oldEvent in InputMap.get_action_list("ship_go_backward"):
			InputMap.action_erase_event("ship_go_backward", oldEvent)
		# Apply new keybind
		var event = InputEventKey.new()
		event.scancode = config.get_value("keybinds", "ship_go_backward")
		InputMap.action_add_event("ship_go_backward", event)
	if config.has_section_key("keybinds", "ship_rotate_left"):
		# Erase old keybind
		for oldEvent in InputMap.get_action_list("ship_rotate_left"):
			InputMap.action_erase_event("ship_rotate_left", oldEvent)
		# Apply new keybind
		var event = InputEventKey.new()
		event.scancode = config.get_value("keybinds", "ship_rotate_left")
		InputMap.action_add_event("ship_rotate_left", event)
	if config.has_section_key("keybinds", "ship_rotate_right"):
		# Erase old keybind
		for oldEvent in InputMap.get_action_list("ship_rotate_right"):
			InputMap.action_erase_event("ship_rotate_right", oldEvent)
		# Apply new keybind
		var event = InputEventKey.new()
		event.scancode = config.get_value("keybinds", "ship_rotate_right")
		InputMap.action_add_event("ship_rotate_right", event)
	if config.has_section_key("keybinds", "ship_shoot"):
		# Erase old keybind
		for oldEvent in InputMap.get_action_list("ship_shoot"):
			InputMap.action_erase_event("ship_shoot", oldEvent)
		# Apply new keybind
		var event = InputEventKey.new()
		event.scancode = config.get_value("keybinds", "ship_shoot")
		InputMap.action_add_event("ship_shoot", event)
	if config.has_section_key("keybinds", "ui_pause"):
		# Erase old keybind
		for oldEvent in InputMap.get_action_list("ui_pause"):
			InputMap.action_erase_event("ui_pause", oldEvent)
		# Apply new keybind
		var event = InputEventKey.new()
		event.scancode = config.get_value("keybinds", "ui_pause")
		InputMap.action_add_event("ui_pause", event)
