extends Node

var inReassignMode = false
var actionReassigning = ""
var buttonReassigning

func _ready():
	$VBoxContainer/VolumeContainer/VolumeSlider.grab_focus()
	set_process_input(true)


##TODO::Handle Pause Button

## NOTE: Bug with reassigning spacebar will double call ui_accept
## Fixed in godot/master
func _input(event):
	# Ignore non key input events
	if not event is InputEventKey:
		return
	
	# Ignore input if not trying to reassign
	if inReassignMode == false:
		###TODO Want to go to previous screen if cancel pressed here
		#if event.is_action("ui_cancel"):
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
	###TODO Clear high scores
	pass 


# Handle all of the Control button remaps
func _on_ForwardButton_pressed():
	inReassignMode = true
	actionReassigning = "ship_go_forward"
	buttonReassigning = $VBoxContainer/GridContainer/ForwardButton
func _on_BackButton_pressed():
	#inReassignMode = true
	#buttonReassigning = "ship_go_back"
	pass
func _on_TurnCCWButton_pressed():
	inReassignMode = true
	buttonReassigning = $VBoxContainer/GridContainer/TurnCCWButton
	actionReassigning = "ship_turn_left"
func _on_TurnCWButton_pressed():
	inReassignMode = true
	buttonReassigning = $VBoxContainer/GridContainer/TurnCWButton
	actionReassigning = "ship_turn_right"
func _on_ShootButton_pressed():
	inReassignMode = true
	buttonReassigning = $VBoxContainer/GridContainer/ShootButton
	actionReassigning = "ship_shoot"
func _on_ConfirmButton_pressed():
	#inReassignMode = true
	#buttonReassigning = $VBoxContainer/GridContainer/ConfirmButton
	pass
func _on_CancelButton_pressed():
	#inReassignMode = true
	#buttonReassigning = $VBoxContainer/GridContainer/CancelButton
	pass
	