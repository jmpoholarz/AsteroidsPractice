extends Panel

var mouseInButton = false

func _ready():
	pass


func _process(delta):
	if self.visible == true:
		if $IgnoreInputTimer.is_stopped():
			if Input.is_action_just_pressed('ui_pause'):
				_on_ResumeButton_button_up()


func _on_ResumeButton_button_up():
	get_tree().paused = false
	# Hide pause window
	self.visible = false


func _on_Timer_timeout():
	# Flip PauseLabel visibility
	if $VBoxContainer/PauseLabel.text == "":
		$VBoxContainer/PauseLabel.text = "Paused"
	else: $VBoxContainer/PauseLabel.text = ""
	# Restart timer
	$LabelTimer.start()


func _on_PauseWindow_visibility_changed():
	if self.visible == true:
		$IgnoreInputTimer.start()
