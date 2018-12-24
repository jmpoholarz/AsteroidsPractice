extends Node

signal scoreConfirmed

onready var leftArrow = get_node("VerticalContainer/ArrowContainer/LeftArrow")
onready var midArrow = get_node("VerticalContainer/ArrowContainer/MidArrow")
onready var rightArrow = get_node("VerticalContainer/ArrowContainer/RightArrow")
onready var leftLetter = get_node("VerticalContainer/LetterContainer/First")
onready var midLetter = get_node("VerticalContainer/LetterContainer/Middle")
onready var rightLetter = get_node("VerticalContainer/LetterContainer/Last")

var selectedLetter = 0
var letterValue = 65

func _ready():
	leftArrow.text = '^'
	midArrow.text = ' '
	rightArrow.text = ' '
	setArrow(0)


func _input(event):
	if $".".visible == false:
		pass
	elif Input.is_action_just_released('ship_rotate_right'):
		selectedLetter += 1
		setArrow(selectedLetter)
		SoundManager.playSFX(SoundManager.BLIP)
	elif Input.is_action_just_released('ship_rotate_left'):
		selectedLetter -= 1
		setArrow(selectedLetter)
		SoundManager.playSFX(SoundManager.BLIP)
	elif Input.is_action_just_released('ship_go_forward'):
		letterValue += 1
		setLetter(letterValue, selectedLetter)
		SoundManager.playSFX(SoundManager.BLIP)
	elif Input.is_action_just_released('ship_go_backward'):
		letterValue -= 1
		setLetter(letterValue, selectedLetter)
		SoundManager.playSFX(SoundManager.BLIP)
	elif Input.is_action_just_released('ui_accept'):
		if $VerticalContainer/LetterContainer/DoneButton.has_focus():
			emit_signal('scoreConfirmed')
		SoundManager.playSFX(SoundManager.ACCEPT)
	


func setLetter(ascii, position):
	# Fix wrapping
	if ascii == 31:
		ascii = 90
	elif ascii == 33:
		ascii = 65
	elif ascii == 64:
		ascii = 32
	elif ascii == 91:
		ascii = 32
	letterValue = ascii
	
	# Update letter value
	if position == 0:
		leftLetter.text = str(char(ascii))
	elif position == 1:
		midLetter.text = str(char(ascii))
	elif position == 2:
		rightLetter.text = str(char(ascii))


func setArrow(position):
	# Update Arrow Visibility
	leftArrow.text = ' '
	midArrow.text = ' '
	rightArrow.text = ' '
	$VerticalContainer/LetterContainer/DoneButton.release_focus()

	match position:
		-1: # Handle underflow
			#rightArrow.text = '^'
			selectedLetter = 3
			$VerticalContainer/LetterContainer/DoneButton.grab_focus()
		0: 
			leftArrow.text = '^'
		1:
			midArrow.text = '^'
		2:
			rightArrow.text = '^'
		3:
			$VerticalContainer/LetterContainer/DoneButton.grab_focus()
		4: # Handle overflow
			leftArrow.text = '^'
			selectedLetter = 0
	
	# Update Stored Letter Value
	if selectedLetter == 0:
		letterValue = leftLetter.text.to_ascii()[0]
	elif selectedLetter == 1:
		letterValue = midLetter.text.to_ascii()[0]
	elif selectedLetter == 2:
		letterValue = rightLetter.text.to_ascii()[0]


func setScoreText(score):
	$VerticalContainer/ScoreLabel.text = str(score)

