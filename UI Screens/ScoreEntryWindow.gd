extends Node

onready var leftArrow = get_node("Panel/VerticalContainer/ArrowContainer/LeftArrow")
onready var midArrow = get_node("Panel/VerticalContainer/ArrowContainer/MidArrow")
onready var rightArrow = get_node("Panel/VerticalContainer/ArrowContainer/RightArrow")
onready var leftLetter = get_node("Panel/VerticalContainer/LetterContainer/First")
onready var midLetter = get_node("Panel/VerticalContainer/LetterContainer/Middle")
onready var rightLetter = get_node("Panel/VerticalContainer/LetterContainer/Last")

var selectedLetter = 0
var letterValue = 65

func _ready():
	leftArrow.text = '^'
	midArrow.text = ' '
	rightArrow.text = ' '
	setArrow(0)


func _input(event):
	if Input.is_action_just_released('ship_rotate_right'):
		selectedLetter += 1
		setArrow(selectedLetter)
	elif Input.is_action_just_released('ship_rotate_left'):
		selectedLetter -= 1
		setArrow(selectedLetter)
	elif Input.is_action_just_released('ship_go_forward'):
		letterValue += 1
		setLetter(letterValue, selectedLetter)
	elif Input.is_action_just_released('ship_go_backward'):
		letterValue -= 1
		setLetter(letterValue, selectedLetter)
	


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

	match position:
		-1: # Handle underflow
			rightArrow.text = '^'
			selectedLetter = 2
		0: 
			leftArrow.text = '^'
		1:
			midArrow.text = '^'
		2:
			rightArrow.text = '^'
		3: # Handle overflow
			leftArrow.text = '^'
			selectedLetter = 0
	
	# Update Stored Letter Value
	if selectedLetter == 0:
		letterValue = leftLetter.text.to_ascii()[0]
		print(letterValue)
	elif selectedLetter == 1:
		letterValue = midLetter.text.to_ascii()[0]
		print(letterValue)
	elif selectedLetter == 2:
		letterValue = rightLetter.text.to_ascii()[0]
		print(letterValue)


