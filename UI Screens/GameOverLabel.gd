extends Label

signal gameOverLabelExpired

func _ready():
	pass

func _on_Timer_timeout():
	emit_signal('gameOverLabelExpired')
